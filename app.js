var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var clientRouter = require('./src/controllers/tour');
var adminRouter = require('./admin_src/admin');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use('/public', express.static('public'));
app.use(express.static(path.join(__dirname, 'public')));

//connect nodejs
var sql = require("mssql");

// var config = {
//   user: 'sa',
//   password: 'sa',
//   server: 'localhost', 
//   database: 'qltour' ,
//   trustServerCertificate: true
// };

// sql.connect(config, function (err) {
//   if (err) console.log(err) 
//   else console.log('Connect to database successfully');
//   // var request = new sql.Request();
//   // // query to the database and get the records
//   // request.query('select * from tour', function (err, recordset) {
//   //     if (err) console.log(err)
//   //     // send records as a response
//   //     console.log(recordset);
//   // });
// });

//api routes
app.use('/', clientRouter);
app.use('/users', adminRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
