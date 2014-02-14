(function() {
  var User, passport;

  passport = require('passport');

  User = require('./models/user');

  module.exports = function(app) {
    app.get('/', function(req, res) {
      return res.render('index', {
        user: req.user
      });
    });
    app.get('/register', function(req, res) {
      return res.render('register', {});
    });
    app.post('/register', function(req, res) {
      return User.register(new User({
        username: req.body.username
      }), req.body.password, function(err, user) {
        if (err) {
          res.render('register', {
            user: user
          });
        }
        return res.redirect('/');
      });
    });
    app.get('/login', function(req, res) {
      return res.render('login', {
        user: req.user
      });
    });
    app.post('/login', passport.authenticate('local'), function(req, res) {
      return res.redirect('/');
    });
    return app.get('/logout', function(req, res) {
      req.logout();
      return res.redirect('/');
    });
  };

}).call(this);
