module.exports = app => {
    const express = require('express')
    const router = express.Router()
    // 引入数据库模型
    const { ChoiceQuestion } = require('../../models/admin/ChoiceQuestion')

    // 存入数据
    router.post('/', async (req, res) => {
        // 创建数据
        await ChoiceQuestion.create({ 'question': req.body }, (err, data) => {
            res.send(data)
        })
    })

    // 获取选择题列表
    router.get('/', async (req, res) => {
        const items = await ChoiceQuestion.find()
        res.send(items)
    })

    // 删除题目
    router.delete('/:id', async (req, res) => {
        await ChoiceQuestion.findByIdAndDelete(req.params.id, req.body)
        // 发回客户端
        res.send({
            success: '删除成功'
        })
    })
    router.get('/length', async (req, res) => {
        console.log('get length')
        const items = await ChoiceQuestion.find()
        console.log('get length is ' + items.length)
        res.send(items.length)
    })

    // 根据分类id查找
    router.get('/:id', async (req, res) => {
        console.log(req.params.id)
        await ChoiceQuestion.find({ 'question.category.categoryId': req.params.id }, (err, data) => {
            // 把根据分类查找出来的题目返回到前端
            res.send(data)
        })
    })

    // 高频错题接口
    router.get('/highwrong/:title', async (req, res) => {
        console.log(req.params.title)
        // res.send("200")
        const items = await ChoiceQuestion.find({ 'question.title': req.params.title })
        console.log(items)
        res.send(items)
    })

    // 修改
    router.put('/:id', async (req, res) => {
        console.log(req.params.id)//url里的id
        console.log(req.body)//传到后端的数据
        const model = await ChoiceQuestion.findByIdAndUpdate(req.params.id, { 'question': req.body })
        // 发回客户端
        res.send(model)
    })

    // 路由挂载
    app.use('/web/api/choiceQuestion', router)
}