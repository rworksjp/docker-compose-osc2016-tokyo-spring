var fs = require('fs');
var _ = require('lodash');
var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');

var app = express();

app.set('port', (process.env.PORT || 3000));

app.use('/', express.static(path.join(__dirname, 'public')));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

app.use(function(req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Cache-Control', 'no-cache');
  next();
});

app.get('/message', function(req, res) {
  var messages = [
    {title: "error", message: "got error"},
    {title: "message 1", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"},
    {title: "message 2", message: "The quick brown fox jumps over the lazy dog"},
    {title: "message 3", message: "あのイーハトーヴォのすきとおった風、夏でも底に冷たさをもつ青いそら、うつくしい森で飾られたモリーオ市、郊外のぎらぎらひかる草の波。"}
  ];
  res.json(_.sample(messages));
});

app.listen(app.get('port'), '0.0.0.0', function() {
  console.log('Server started on 0.0.0.0:' + app.get('port'));
});
