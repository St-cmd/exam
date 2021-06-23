const e = require('express')

module.exports = app => {
	const express = require('express')
	const router = express.Router()
	// 引入数据库模型
	const {
		UserInfo
	} = require('../../models/before/UserInfo')

	// 存入数据
	router.post('/', async (req, res) => {
		const {
			username,
			password
		} = req.body
		// 1.根据用户名找用户
		const user = await UserInfo.findOne({
			username
		})
		if (!user || user == "undefined") {
			UserInfo.create(req.body, (err, data) => {
				res.send(200)
			})
		} else {
			return res.status(203).send({
				message: '用户不存在'
			})
		}
	})

	//修改昵称
	router.post('/edit_nick', async (req, res) => {
		const username = req.body.username;
		const changename = req.body.changename;
		// 1.根据用户名找用户
		const user = await UserInfo.findOne({
			username
		})
		if (!user || user == "undefined") {
			return res.status(203).send({
				message: '系统错误'
			})
		}
		const changeuser = await UserInfo.findOne({
			"username": changename
		});
		if (!changeuser || changeuser == "undefined") {
			user.username = changename;
			user.save();
			res.send(200);
		} else {
			return res.status(203).send({
				message: '该用户名已被使用'
			})
		}
	})

	//修改密码
	router.post('/edit_pwd', async (req, res) => {
		const username = req.body.username;
		const pwd = req.body.pwd;
		// 1.根据用户名找用户
		const user = await UserInfo.findOne({
			username
		})
		if (!user || user == "undefined") {
			return res.status(203).send({
				message: '系统错误'
			})
		}
		user.password = pwd;
		user.save();
		res.send(200);
	})

	// 判断是否有该用户名和密码
	router.post('/match', async (req, res) => {
		const {
			username,
			password
		} = req.body
		console.log(username)
		console.log(password)
		// 1.根据用户名找用户
		const user = await UserInfo.findOne({
			username
		})
		console.log(user)
		if (!user || user == "undefined") {
			return res.status(203).send({
				message: '用户不存在'
			})
		}
		console.log(user)
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
		const items = await UserInfo.find().populate('pre').limit(10)
		// 发回客户端
		res.send(items)
	})

	// 删除分类
	router.delete('/:id', async (req, res) => {
		await UserInfo.findByIdAndDelete(req.params.id, req.body)
		// 发回客户端
		res.send({
			success: true
		})
	})

	// 获取分类详情返回到修改界面展示
	router.get('/:id', async (req, res) => {
		// console.log(typeof req.params.id)
		const model = await UserInfo.findById(req.params.id, (err, data) => {
			res.send(data)
		})
	})

	// 修改分类 传回后端储存
	router.put('/:id', async (req, res) => {
		// console.log(req.params.id)//url里的id
		// console.log(req.body)//传到后端的数据
		const model = await UserInfo.findByIdAndUpdate(req.params.id, req.body)
		// 发回客户端
		res.send(model)
	})
	// 路由挂载
	app.use('/web/api/userinfo', router)
}
