 mongoose = require 'mongoose'
 Schema = mongoose.Schema
 passportLocalMongoose = require 'passport-local-mongoose'

 User = new Schema({
	 nickname: String
	 birthday: Date
 })

 User.plugin(passportLocalMongoose)

 module.exports = mongoose.model('User', User)
