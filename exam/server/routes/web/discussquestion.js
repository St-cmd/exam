module.exports = app => {
    const express = require('express')
    const router = express.Router()
    // 引入数据库模型
    const { DiscussQuestion } = require('../../models/admin/DiscussQuestion')

    // 存入数据
    router.post('/', async (req, res) => {
        // 创建数据
        await DiscussQuestion.create({ 'question': req.body }, (err, data) => {
            res.send(data)
        })
    })

    // 获取论述题列表
    router.get('/', async (req, res) => {
        const items = await DiscussQuestion.find()
        res.send(items)
    })

    // 删除题目
    router.delete('/:id', async (req, res) => {
        await DiscussQuestion.findByIdAndDelete(req.params.id, req.body)
        // 发回客户端
        res.send({
            success: '删除成功'
        })
    })

    // 根据id查找
    router.get('/:id', async (req, res) => {
        console.log(req.params.id)
		await DiscussQuestion.find({ 'question.category.categoryId': req.params.id }, (err, data) => {
		    // 把根据分类查找出来的题目返回到前端
		    res.send(data)
		})
    })

    // 修改
    router.put('/:id', async (req, res) => {
        // console.log(req.params.id)//url里的id
        // console.log(req.body)//传到后端的数据
        const model = await DiscussQuestion.findByIdAndUpdate(req.params.id, { 'question': req.body })
        // 发回客户端
        res.send(model)
    })

    // 高频错题接口
    router.get('/highwrong/:title', async (req, res) => {
        console.log(req.params.title)
        // res.send("200")
        const items = await DiscussQuestion.find({ 'question.title': req.params.title })
        console.log(items)
        res.send(items)
    })

    // 路由挂载
    app.use('/web/api/discussQuestion', router)
}