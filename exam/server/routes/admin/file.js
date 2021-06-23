module.exports = app => {
	const express = require('express')
	const router = express.Router()
	// 引入数据库模型
	const {
		File
	} = require('../../models/admin/File')
	const fs = require("fs");
	const parse = require('csv-parse/lib/sync')
	const {
		ChoiceQuestion
	} = require('../../models/admin/ChoiceQuestion')
	const {
		DiscussQuestion
	} = require('../../models/admin/DiscussQuestion')
	const {
		JudgedQuestion
	} = require('../../models/admin/JudgedQuestion')
	const {
		MultipleChoiceQuestion
	} = require('../../models/admin/MultipleChoiceQuestion')
	const {
		Category
	} = require('../../models/admin/Category')

	// 存文件
	router.post('/', async (req, res) => {
		// 创建数据
		// console.log(req.body)
		var icon = req.body.icon
		console.log('req======', req.body.icon)
		console.log(icon.split('/').pop())
		await File.create({
			'model': req.body
		}, (err, data) => {
			res.send(data)
		})
		fs = require('fs')
		fs.readFile('../server/upload/' + icon.split('/').pop(), function(err, data) {
			if (err) throw err;
			// console.log(JSON.parse(data.toString()))
			console.log(data.toString())
		})
	})



	// 获取文件列表
	router.get('/', async (req, res) => {
		const model = await File.find()
		res.send(model)
	})

	// 删除文件
	router.delete('/:id', async (req, res) => {
		await File.findByIdAndDelete(req.params.id, req.body)
		// 发回客户端
		res.send({
			success: '删除成功'
		})
	})


	// 上传文件接口
	const multer = require('multer')
	// __dirname 表示当前文件所在的位置--admin/index.js
	const upload = multer({
		dest: __dirname + '/../../upload'
	})
	// 上传到数据库
	// upload.single('file') -- file 是接口传递过来的formdata中的字段名，el-ui默认值是file
	router.post('/upload', upload.single('file'), async (req, res) => {
		const file = req.file
		file.url = `http://localhost:6500/upload/${file.filename}`
		res.send(file)
	})

	//文件解析为题库
	router.get('/analyze', async (req, res) => {
		var data = fs.readFileSync(__dirname + "/../../upload/" + req.query["filename"]);
		var records = parse(data, {
			columns: true,
			skip_empty_lines: true
		});
		if (req.query["questionType"] == 0) {
			for (var record of records) {
				var category = await Category.findById(record.categoryId);
				var categoryName = category.name;
				let doc = {
					"question": {
						"title": record.title,
						"answerA": record.answerA,
						"answerB": record.answerB,
						"answerC": record.answerC,
						"answerD": record.answerD,
						"rightAnswer": record.rightAnswer,
						"category": {
							"categoryId": record.categoryId,
							"categoryName": categoryName
						},
						"rate": record.rate
					}
				}
				ChoiceQuestion.create(doc);
			}
		} else if (req.query["questionType"] == 1) {
			for (var record of records) {
				var category = await Category.findById(record.categoryId);
				var categoryName = category.name;
				let doc = {
					"question": {
						"title": record.title,
						"answerA": record.answerA,
						"answerB": record.answerB,
						"answerC": record.answerC,
						"answerD": record.answerD,
						"rightAnswer": record.rightAnswer.split(","),
						"category": {
							"categoryId": record.categoryId,
							"categoryName": categoryName
						},
						"rate": record.rate
					}
				}
				MultipleChoiceQuestion.create(doc);
			}
		} else if (req.query["questionType"] == 2) {
			for (var record of records) {
				var category = await Category.findById(record.categoryId);
				var categoryName = category.name;
				let doc = {
					"question": {
						"title": record.title,
						"rightAnswer": record.rightAnswer,
						"category": {
							"categoryId": record.categoryId,
							"categoryName": categoryName
						},
						"rate": record.rate
					}
				}
				JudgedQuestion.create(doc);
			}
		} else if (req.query["questionType"] == 3) {
			for (var record of records) {
				var category = await Category.findById(record.categoryId);
				var categoryName = category.name;
				let doc = {
					"question": {
						"title": record.title,
						"rightAnswer": record.rightAnswer,
						"category": {
							"categoryId": record.categoryId,
							"categoryName": categoryName
						},
						"rate": record.rate
					}
				}
				DiscussQuestion.create(doc);
			}
		}
		res.send("success")
	})
	// 路由挂载
	app.use('/admin/api/file', router)
}
