const mongoose = require('mongoose')

const schema = new mongoose.Schema({
    id: {
        type: Number
    },
    question: {
        title: { type: String },
        rightAnswer: { type: String },
        category: {
            categoryId: { type: String },
            categoryName: { type: String }
        },
        rate: { type: Number }
    }
})

schema.index({ id: 1 });

const DiscussQuestion = mongoose.model('DiscussQuestion', schema)
module.exports = { DiscussQuestion }
