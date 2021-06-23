module.exports = app => {
	const express = require('express')
	const router = express.Router()
	// 引入数据库模型
	const {
		WrongQuestion
	} = require('../../models/before/WrongQuestion')
	const {
		ChoiceQuestion
	} = require('../../models/admin/ChoiceQuestion')
	const {
		MultipleChoiceQuestion
	} = require('../../models/admin/MultipleChoiceQuestion')
	const {
		JudgedQuestion
	} = require('../../models/admin/JudgedQuestion')
	const {
		DiscussQuestion
	} = require('../../models/admin/DiscussQuestion')

	// 存入数据
	router.post('/', async (req, res) => {
		for (let i = 0; i < req.body.length; i++) {
			var item = {
				"questionId": req.body[i].questionId,
				"categoryId": req.body[i].category.categoryId,
				"username": req.body[i].username
			};
			var existItem = await WrongQuestion.findOne({
				'questionId': item.questionId,
				'username': item.username
			});
			if (existItem == null || existItem == undefined) {
				await WrongQuestion.create(item)
			}
		}
		res.send('success')
	})

	// 获取选择的题列表
	router.get('/', async (req, res) => {
		var items = await WrongQuestion.find({
			"username": req.query["username"],
			"categoryId": req.query["categoryId"]
		}).lean();//lean将mongo中的文档形式转化为Object形式
		var result = [];
		if (req.query["questionType"] == 0) {
			for (var item of items) {
				var tmp = await ChoiceQuestion.findById(item.questionId);
				if (tmp != null) {
					result.push(tmp);
				}
			}
		} else if (req.query["questionType"] == 1) {
			for (var item of items) {
				var tmp = await MultipleChoiceQuestion.findById(item.questionId);
				if (tmp != null) {
					result.push(tmp);
				}
			}
		} else if (req.query["questionType"] == 2) {
			for (var item of items) {
				var tmp = await JudgedQuestion.findById(item.questionId);
				if (tmp != null) {
					result.push(tmp);
				}
			}
		} else if (req.query["questionType"] == 3) {
			for (var item of items) {
				var tmp = await DiscussQuestion.findById(item.questionId);
				if (tmp != null) {
					result.push(tmp);
				}
			}
		}
		res.send(result);
	})

	router.post('/length', async (req, res) => {
		console.log('get wrong question length ' + req.body.username)
		const items = await WrongQuestion.find(req.body)
		res.send(items.length)
	})

	router.post('/list', async (req, res) => {
		console.log('get wrong question list ' + req.body.username)
		await WrongQuestion.find(req.body, (err, data) => {
			console.log('length is ' + data.length)
			res.send(data)
			console.log(data)
		})
	})

	// 删除题目
	router.delete('/:id', async (req, res) => {
		await WrongQuestion.findByIdAndDelete(req.params.id, req.body)
		// 发回客户端
		res.send({
			success: '删除成功'
		})
	})
	router.post('/clear', async (req, res) => {
		const clearItems = await WrongQuestion.deleteMany({
			"username":req.body.username
		});
		// 发回客户端
		res.send('清空成功')
	})

	// 获取分类详情返回到修改界面展示
	router.get('/:id', async (req, res) => {
		// console.log(typeof req.params.id)
		await WrongQuestion.findById(req.params.id, (err, data) => {
			res.send(data)
		})
	})
	// //根据title获取题目
	// router.get('/:details', async (req, res) => {
	//     console.log(req.params)
	//     await WrongQuestion.find('title', req.params.title, (err, data) => {
	//         res.send(data)
	//     })
	// })

	// 高频错题接口
	router.get('/highwrong', async (req, res) => {
		console.log(req.params.tittle)
		res.send("200")
		// const items = await WrongQuestion.find({ 'title': req.params.title })
		// console.log(items)
		// res.send(items)
	})

	// 修改
	router.put('/:id', async (req, res) => {
		// console.log(req.params.id)//url里的id
		// console.log(req.body)//传到后端的数据
		const model = await WrongQuestion.findByIdAndUpdate(req.params.id, {
			'question': req.body
		})
		// 发回客户端
		res.send(model)
	})
	// 路由挂载
	app.use('/web/api/wrongquestion', router)
}
