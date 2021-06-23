module.exports = app => {
    const express = require('express')
    const router = express.Router()
    // 引入数据库模型
    const { Category } = require('../../models/admin/Category')

    // 存入数据
    router.post('/', async (req, res) => {
        // console.log(req.body)
        const model = Category.create(req.body)
        res.send(model)
    })

    // 获取数据
    router.get('/', async (req, res) => {
        // const items = await req.Model.find().populate('parent').limit(10)
        // const items = await Category.find().populate('pre').limit(10)
        const items = await Category.find().populate('pre')
        // 发回客户端
        res.send(items)
    })

    // 删除分类
    router.delete('/:id', async (req, res) => {
        await Category.findByIdAndDelete(req.params.id, req.body)
        // 发回客户端
        res.send({
            success: true
        })
    })

    // 获取分类详情返回到修改界面展示
    router.get('/:id', async (req, res) => {
        // console.log(typeof req.params.id)
        const model = await Category.findById(req.params.id, (err, data) => {
            res.send(data)
        })
    })

    // 修改分类 传回后端储存
    router.put('/:id', async (req, res) => {
        // console.log(req.params.id)//url里的id
        // console.log(req.body)//传到后端的数据
        const model = await Category.findByIdAndUpdate(req.params.id, req.body)
        // 发回客户端
        res.send(model)
    })
    // 路由挂载
    app.use('/admin/api/category', router)
}