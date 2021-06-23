module.exports = app => {
    const express = require('express')
    const router = express.Router()
    // 引入数据库模型
    const { Login } = require('../../models/admin/Login')
    const { AdminInfo } = require('../../models/admin/AdminInfo')


    // TODO 删掉此处冗余代码
    // 存入用户名密码
    router.post('/', async (req, res) => {
        const { username, password } = req.body
        console.log(username)
        console.log(password)

        // 1.根据用户名找用户
        const user = await AdminInfo.findOne({ username })
        if (!user || user == "undefined") {
            return res.status(203).send({
                message: '用户不存在'
            })
        }
        // console.log(user)
        AdminInfo.create(req.body, (err, data) => {
            console.log(data)
            // console.log(data)
            res.send(200)
        })
    })

    // 判断是否有该用户名和密码
    router.post('/match', async (req, res) => {
        const { username, password } = req.body
        console.log(username)
        console.log(password)

        // 1.根据用户名找用户
        const user = await AdminInfo.findOne({ username })
        if (!user || user == "undefined") {
            return res.status(203).send({
                message: '用户不存在'
            })
        }
        // console.log(user)
        require('bcryptjs').compare(password, user.password, function(err, result) {
            if (result) {
                console.log('密码匹配')
                res.send(200)
            } else {
                console.log('密码不匹配')
                res.send(203)
            }
        })
    })

    // 获取数据
    router.get('/', async (req, res) => {
        // const items = await req.Model.find().populate('parent').limit(10)
        const items = await Login.find().populate('pre').limit(10)
        // 发回客户端
        res.send(items)
    })

    // 删除分类
    router.delete('/:id', async (req, res) => {
        await Login.findByIdAndDelete(req.params.id, req.body)
        // 发回客户端
        res.send({
            success: true
        })
    })

    // 获取分类详情返回到修改界面展示
    router.get('/:id', async (req, res) => {
        // console.log(typeof req.params.id)
        const model = await Login.findById(req.params.id, (err, data) => {
            res.send(data)
        })
    })

    // 修改分类 传回后端储存
    router.put('/:id', async (req, res) => {
        // console.log(req.params.id)//url里的id
        // console.log(req.body)//传到后端的数据
        const model = await Login.findByIdAndUpdate(req.params.id, req.body)
        // 发回客户端
        res.send(model)
    })
    // 路由挂载
    app.use('/admin/api/login', router)
}