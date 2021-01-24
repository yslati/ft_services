// This script to test if you can connect to Your MySQL outside localhost
//
// Run those commands first:
// brew install node
// npm i mysql
//
// then replace " host, user, password " with your Mysql info
// run the script and check if the output is Connected or not.


const mysql = require('mysql');

var con = mysql.createConnection({
  host: "machine_IP",
  user: "Mysql_username",
  password: "MySQL_Password"
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");

});
