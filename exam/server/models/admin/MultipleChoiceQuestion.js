const mongoose = require('mongoose')

const schema = new mongoose.Schema({
    id: {
        type: Number
    },
    question: {
        title: { type: String },
        answerA: { type: String },
        answerB: { type: String },
        answerC: { type: String },
        answerD: { type: String },
        rightAnswer: { type: Array },
        category: {
            categoryId: { type: String },
            categoryName: { type: String }
        },
        rate: { type: Number }
    }
})

schema.index({ id: 1 });

const MultipleChoiceQuestion = mongoose.model('MultipleChoiceQuestion', schema)
module.exports = { MultipleChoiceQuestion }
