// This script to test if you can connect to Your MySQL outside localhost
//
// Run those commands first:
// brew install node
// npm i mysql
//
// then replace " host, user, password " with your Mysql info
// run the script and check if the output is Connected or not.


const mysql = require('mysql');
  2
  3 var con = mysql.createConnection({
  4   host: "machine_IP",
  5   user: "Mysql_username",
  6   password: "MySQL_Password"
  7 });
  8
  9 con.connect(function(err) {
 10   if (err) throw err;
 11   console.log("Connected!");
 12
 13 });
