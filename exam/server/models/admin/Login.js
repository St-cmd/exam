const mongoose = require('mongoose')

const schema = new mongoose.Schema({
    username: { type: String },
    password: {
        type: String
    } 
})

const Login = mongoose.model('Login', schema)
module.exports = { Login }