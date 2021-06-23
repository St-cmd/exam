const mongoose = require('mongoose')

const schema = new mongoose.Schema({
	questionId: {
		type: String
	},
	categoryId: {
		type: String
	},
	username: {
		type: String
	}
})

const WrongQuestion = mongoose.model('WrongQuestion', schema)
module.exports = {
	WrongQuestion
}
