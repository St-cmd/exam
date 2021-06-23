const mongoose = require('mongoose')

const schema = new mongoose.Schema({
    name: { type: String },
    pre: { type: mongoose.SchemaTypes.ObjectId, ref: 'Category' } 
})

const Category = mongoose.model('Category', schema)
module.exports = { Category }