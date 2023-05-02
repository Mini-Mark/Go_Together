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
        status: false,
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
                status: true,
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
        status: false,
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
                  status: true,
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
            status: false,
          });
        }
      });
    }
  });
});

// endpoint: /login

// /Settings
app.put("/settings", async (req, res) => {
  try {
    const { userID, name, tel, password, oldPassword } = req.body;

    const sqlSelect = "SELECT * FROM users WHERE userID = ?";
    connection.execute(sqlSelect, [userID], async (error, results) => {
      if (error) {
        return res.status(500).json({
          status: false,
          message: "Database error",
        });
      }

      if (results.length === 0) {
        return res.status(404).json({
          status: false,
          message: "User not found",
        });
      }

      const user = results[0];

      if (oldPassword !== undefined) {
        const isOldPasswordValid = await bcrypt.compare(
          oldPassword,
          user.password
        );
        if (!isOldPasswordValid) {
          return res.status(400).json({
            status: false,
            message: "Invalid old password",
          });
        }
      }

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
        status: true,
        message: "User profile updated successfully",
        user: user,
      });
    });
  } catch (err) {
    console.error(err.message);
    return res.status(500).json({
      status: false,
      message: "Server error",
    });
  }
});
// endpoint: /Settings

// /riderRegister
app.put("/riderRegister", async (req, res) => {
  const {
    userID,
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
          status: false,
          message: err.message,
        });
        return;
      } else {
        res.status(200).json({
          status: true,
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
        status: false,
        message: err.message,
      });
    } else if (result.length === 0) {
      res.status(400).json({
        status: false,
        message: "User not found",
      });
    } else {
      connection.beginTransaction((err) => {
        if (err) {
          res.status(500).json({
            status: false,
            message: err.message,
          });
          return;
        }

        connection.execute(sqlDeletePost, [userID], (err) => {
          if (err) {
            return connection.rollback(() => {
              res.status(500).json({
                status: false,
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
                    status: false,
                    message: err.message,
                  });
                });
              }
              connection.commit((err) => {
                if (err) {
                  return connection.rollback(() => {
                    res.status(500).json({
                      status: false,
                      message: err.message,
                    });
                  });
                }
                res.status(200).json({
                  status: true,
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
      "SELECT post.*, users.* FROM post JOIN users ON post.userID = users.userID";

    if (locationDestination) {
      sql += ` WHERE post.locationDestination LIKE '%${locationDestination}%'`;
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
app.get("/postDetail/:postID", async (req, res) => {
  const { postID } = req.params;
  let sql =
    "SELECT post.*, users.* FROM post JOIN users ON post.userID = users.userID WHERE post.postID = ?";
  connection.query(sql, [postID], (err, posts) => {
    if (err) {
      res.status(500).json({
        message: err.message,
      });
      return;
    }
    res.status(200).json({
      message: "Success",
      data: posts,
    });
  });
});
// endpoint: /PostDetail

// /getNotificationRider
app.get("/getNotificationRider/:userID", (req, res) => {
  const { userID } = req.params;

  const sql = "SELECT * FROM seat WHERE userID_rider = userID AND status = '0'";

  connection.query(sql, [userID], (err, results) => {
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
});
// endpoint: /getNotificationRider

// /postRequest
app.post("/postRequest", (req, res) => {
  const { userID_rider, userID } = req.body;

  const checkSql =
    "SELECT COUNT(*) as num_riders FROM seat WHERE userID_rider = ? AND status = 1";

  connection.execute(checkSql, [userID_rider], (err, results) => {
    if (err) {
      res.status(500).json({
        message: err.message,
      });
      return;
    }

    const numRiders = results[0].num_riders;

    const getNumSeatSql = "SELECT seat FROM post WHERE userID = ?";

    connection.execute(getNumSeatSql, [userID_rider], (err, results) => {
      if (err) {
        res.status(500).json({
          message: err.message,
        });
        return;
      }

      const numSeat = results[0].seat;

      if (numRiders >= numSeat) {
        res.status(400).json({
          status: false,
          message: "Seat is full",
        });
        return;
      }

      const checkDuplicateSql = "SELECT * FROM seat WHERE userID = ?";

      connection.execute(checkDuplicateSql, [userID], (err, results) => {
        if (err) {
          res.status(500).json({
            message: err.message,
          });
          return;
        }

        if (results.length > 0) {
          res.status(400).json({
            status: false,
            message: "Duplicate userID",
          });
          return;
        }

        const insertSql =
          "INSERT INTO seat (userID_rider, userID) VALUES (?, ?)";

        connection.execute(
          insertSql,
          [userID_rider, userID],
          (err, results) => {
            if (err) {
              res.status(500).json({
                message: err.message,
              });
              return;
            }
            res.status(200).json({
              status: true,
              message: "Success",
              data: results,
            });
          }
        );
      });
    });
  });
});

// endpoint: /postRequest

// /riderAccept
app.put("/riderAccept", (req, res) => {
  const { userID_rider, userID, status } = req.body;

  const sql =
    "UPDATE seat SET status = ? WHERE userID_rider = ? AND userID = ? AND status = '0'";

  connection.execute(sql, [status, userID_rider, userID], (err, results) => {
    if (err) {
      res.status(500).json({
        message: err.message,
        success: false,
      });
      return;
    }

    if (results.affectedRows === 0) {
      res.status(400).json({
        message: "No seat available for this user",
        success: false,
      });
      return;
    }

    res.status(200).json({
      message: "Success",
      success: true,
    });
  });
});
// endpoint: /riderAccept
