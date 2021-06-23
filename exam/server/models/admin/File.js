const mongoose = require('mongoose')

const schema = new mongoose.Schema({
    model: {
        name: { type: String },
        icon: { type: String } // 保存地址
    }
})

const File = mongoose.model('File', schema)
module.exports = { File }