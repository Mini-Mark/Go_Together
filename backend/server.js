const express = require("express");
const app = express();
const port = 3000;
// get the client
const mysql = require("mysql2");
const bcrypt = require("bcrypt");

const saltRounds = 10;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// create the connection to database
const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "gotogetherapi",
});

if (connection.connect) {
  console.log("Connected to database");
} else {
  console.log("Unable to connect to database");
}

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});

// /register
app.post("/register", async (req, res) => {
  const { email, password, name, tel } = req.body;
  let sql = "SELECT * FROM users WHERE email = ?";
  connection.execute(sql, [email], (err, results) => {
    if (err) {
      return res.status(500).json({
        status: "Error",
        message: "Internal server error",
      });
    } else if (results.length > 0) {
      return res.status(400).json({
        status: "False",
        message: "Email already exists",
      });
    } else {
      bcrypt.genSalt(saltRounds, (err, salt) => {
        bcrypt.hash(password, salt, (err, hash) => {
          let sql =
            "INSERT INTO users (email, password, name, tel) VALUES (?, ?, ?, ?)";
          connection.execute(sql, [email, hash, name, tel], (err, results) => {
            if (err) {
              return res.status(500).json({
                status: "Error",
                message: "Internal server error",
              });
            } else {
              return res.status(200).json({
                status: "True",
                message: "User created",
              });
            }
          });
        });
      });
    }
  });
});
// endpoint: /register

// login
app.post("/login", async (req, res) => {
  const { email, password } = req.body;
  let sql = "SELECT * FROM users WHERE email = ?";
  connection.execute(sql, [email], async (err, results) => {
    if (err) {
      return res.status(500).json({
        status: "Error",
        message: "Internal server error",
      });
    }
    if (results.length == 0) {
      return res.status(200).json({
        status: "False",
      });
    } else {
      const hashedPassword = results[0].password;
      bcrypt.compare(password, hashedPassword, (err, result) => {
        if (result) {
          const userID = results[0].userID;
          if (userID) {
            sql = "SELECT * FROM users WHERE userID = ?";
            connection.execute(sql, [userID], (err, results) => {
              if (err) {
                return res.status(500).json({
                  status: "Error",
                  message: "Internal server error",
                });
              } else {
                return res.status(200).json({
                  status: "True",
                  data: results[0],
                });
              }
            });
          } else {
            return res.status(500).json({
              status: "Error",
              message: "User ID is undefined",
            });
          }
        } else {
          return res.status(200).json({
            status: "False",
          });
        }
      });
    }
  });
});

// endpoint: /login

// /Settings
app.put("/settings/:userID", async (req, res) => {
  try {
    const { userID } = req.params;
    const { name, tel, password } = req.body;

    const sqlSelect = "SELECT * FROM users WHERE userID = ?";
    connection.execute(sqlSelect, [userID], async (error, results) => {
      if (error) {
        return res.status(500).json({
          status: "False",
          message: "Database error",
        });
      }

      if (results.length === 0) {
        return res.status(404).json({
          status: "False",
          message: "User not found",
        });
      }

      const user = results[0];

      if (name !== undefined) {
        const sqlUpdateName = "UPDATE users SET name = ? WHERE userID = ?";
        connection.execute(sqlUpdateName, [name || null, userID]);
        user.name = name;
      }

      if (tel !== undefined) {
        const sqlUpdateTel = "UPDATE users SET tel = ? WHERE userID = ?";
        connection.execute(sqlUpdateTel, [tel || null, userID]);
        user.tel = tel;
      }

      if (password !== undefined) {
        const salt = await bcrypt.genSalt(saltRounds);
        const hashedPassword = await bcrypt.hash(password, salt);
        const sqlUpdatePassword =
          "UPDATE users SET password = ? WHERE userID = ?";
        connection.execute(sqlUpdatePassword, [hashedPassword, userID]);
      }

      return res.status(200).json({
        status: "True",
        message: "User profile updated successfully",
        user: user,
      });
    });
  } catch (err) {
    console.error(err.message);
    return res.status(500).json({
      status: "False",
      message: "Server error",
    });
  }
});
// endpoint: /Settings

// /riderRegister
app.put("/riderRegister/:userID", async (req, res) => {
  const { userID } = req.params;
  const {
    brand,
    model,
    color,
    licenseNo,
    drivingLicense,
    carImage,
    carLicense,
  } = req.body;

  let sql =
    "UPDATE users SET brand = ?, model = ?, color = ?, licenseNo = ?, drivingLicense = ?, carImage = ?, carLicense = ? WHERE userID = ?";
  connection.execute(
    sql,
    [
      brand,
      model,
      color,
      licenseNo,
      drivingLicense,
      carImage,
      carLicense,
      userID,
    ],
    (err, results) => {
      if (err) {
        res.status(500).json({
          status: "False",
          message: err.message,
        });
        return;
      } else {
        res.status(200).json({
          status: "True",
          message: "Success",
          data: results,
        });
      }
    }
  );
});
// endpoint: /riderRegister

// /riderPost
app.post("/riderPost/:userID", async (req, res) => {
  const userID = req.params.userID;
  const { locationSource, locationDestination, seat, online } = req.body;
  let sqlCheckUser = "SELECT * FROM users WHERE userID = ?";
  let sqlDeletePost = "DELETE FROM post WHERE userID = ?";
  let sqlInsertPost =
    "INSERT INTO post (locationSource, locationDestination, seat, online, userID) VALUES (?, ?, ?, ?, ?)";

  connection.execute(sqlCheckUser, [userID], (err, result) => {
    if (err) {
      res.status(500).json({
        status: "False",
        message: err.message,
      });
    } else if (result.length === 0) {
      res.status(400).json({
        status: "False",
        message: "User not found",
      });
    } else {
      connection.beginTransaction((err) => {
        if (err) {
          res.status(500).json({
            status: "False",
            message: err.message,
          });
          return;
        }

        connection.execute(sqlDeletePost, [userID], (err) => {
          if (err) {
            return connection.rollback(() => {
              res.status(500).json({
                status: "False",
                message: err.message,
              });
            });
          }

          connection.execute(
            sqlInsertPost,
            [locationSource, locationDestination, seat, online, userID],
            (err, results) => {
              if (err) {
                return connection.rollback(() => {
                  res.status(500).json({
                    status: "False",
                    message: err.message,
                  });
                });
              }
              connection.commit((err) => {
                if (err) {
                  return connection.rollback(() => {
                    res.status(500).json({
                      status: "False",
                      message: err.message,
                    });
                  });
                }
                res.status(200).json({
                  status: "True",
                  message: "Success",
                  data: results,
                });
              });
            }
          );
        });
      });
    }
  });
});
// endpoint: /riderPost

// riderClosePost
app.put("/riderClosePost/:userID", async (req, res) => {
  const { userID } = req.params;
  let sql = "UPDATE post SET online = 'False' WHERE userID =?";
  connection.execute(sql, [userID], (err, result) => {
    if (err) {
      res.status(500).json({
        message: err.message,
      });
      return;
    } else {
      res.status(200).json({
        message: "Success",
        data: result,
      });
    }
  });
});

// endpoint: /riderClosePost

// /userList
app.get("/userList", async (req, res) => {
  try {
    const { locationDestination } = req.query;
    let sql =
      "SELECT post.*, users.name FROM post JOIN users ON post.userID = users.userID";

    if (locationDestination) {
      sql += " WHERE post.locationDestination = ?";
    }

    connection.query(sql, [locationDestination], (err, results) => {
      if (err) {
        res.status(500).json({
          message: err.message,
        });
        return;
      }
      res.status(200).json({
        message: "Success",
        data: results,
      });
    });
  } catch (err) {
    console.error(err.message);
    res.status(500).json({
      message: "Server error",
    });
  }
});

// endpoint: /userList

// PostDetail
app.post("/PostDetail/:userID", async (req, res) => {
  const { userID } = req.params;
  let sql = "SELECT * FROM users WHERE userID =?";
  connection.query(sql, [userID], (err, users) => {
    if (err) {
      res.status(500).json({
        message: err.message,
      });
      return;
    }
    if (users.length === 0) {
      res.status(404).json({
        message: "User not found",
      });
      return;
    }
    sql = "SELECT * FROM post WHERE userID =?";
    connection.query(sql, [userID], (err, posts) => {
      if (err) {
        res.status(500).json({
          message: err.message,
        });
        return;
      }
      res.status(200).json({
        message: "Success",
        user: users[0],
        posts,
      });
    });
  });
});
// endpoint: /PostDetail

// /getNotificationRider

// endpoint: /getNotificationRider
