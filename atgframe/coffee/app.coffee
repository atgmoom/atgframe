express = require 'express'
mongoose = require 'mongoose'
passport = require 'passport'
LocalStrategy = require('passport-local').Strategy
RedisStore = require('connect-redis')(express)


app = express()

app.configure ->
	app.set('views', __dirname + '/jade')
	app.set('view engine', 'jade')
	app.locals.pretty = true
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use express.cookieParser()
	app.use express.session({
		store: new RedisStore({
			host: 'localhost'
			port: 6379
			db: 2
			pass: 'sadie'}),
		secret: 'sup3r1337s3cre3t'})
	app.use passport.initialize()
	app.use passport.session()
	app.use app.router
#	app.use express.static(require('path').join(__dirname, 'public'))

User = require './models/user'
passport.use(new LocalStrategy(User.authenticate()))
passport.serializeUser User.serializeUser()
passport.deserializeUser User.deserializeUser()
mongoose.connect 'mongodb://localhost/users'

require('./routes')(app)

app.listen(3000)
console.log 'Server is online'
