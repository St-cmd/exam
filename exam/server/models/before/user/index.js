'use strict';

import mongoose from 'mongoose'

const Schema = mongoose.Schema;

const userSchema = new Schema({
    user_name: String,
    password: {
        type: String,
        select: false,// 表示无法被查出
    },
    id: Number,
    create_time: String,
})

userSchema.index({ id: 1 });

const User = mongoose.model('User', userSchema);


export default User
