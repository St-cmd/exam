const mongoose = require('mongoose')

const schema = new mongoose.Schema({
    username: { type: String },
    password: {
        type: String,
        // select: false,// 表示无法被查出
        set: (val) => {
            //用散列方法把密码进行散列,10为密码强度
            return require('bcryptjs').hashSync(val, 10)
        }
    }
})

const UserInfo = mongoose.model('UserInfo', schema)
module.exports = { UserInfo }