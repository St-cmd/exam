module.exports = app => {
	const express = require('express')
	const router = express.Router()
	// 引入数据库模型
	const {
		Exam
	} = require('../../models/admin/Exam')
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


	// 获取数据
	router.get('/list', async (req, res) => {
		// const items = await req.Model.find().populate('parent').limit(10)
		var items = await Exam.find();
		// 发回客户端
		res.send(items)
	})

	//获取题目数据
	router.get('/detail', async (req, res) => {
		//单选
		var tmpChoice = await ChoiceQuestion.find({
			'question.category.categoryId': req.query["id"]
		}).lean();
		console.log(tmpChoice);
		var result = [];
		for (var i = 1; i <= 70; i++) {
			var rd = Math.floor(Math.random() * (tmpChoice.length));
			tmpChoice[rd].questionType = 0;
			result.push(tmpChoice[rd]);
		}  
		// console.log(req.query["id"]);
		//多选
		var tmpMult = await MultipleChoiceQuestion.find({
			'question.category.categoryId': req.query["id"]
		}).lean();
		console.log(tmpMult);
		for(var i=1;i<=10;i++){
			var rd = Math.floor(Math.random() * (tmpMult.length));
			if (tmpMult.length === 0) {
				result.push();
				return;
			}
			else{
				tmpMult[rd].questionType = 1;
				result.push(tmpMult[rd]);
			}
			
		}
		//判断
		var tmpJudge = await JudgedQuestion.find({
			'question.category.categoryId': req.query["id"]
		}).lean();
		for(var i=1;i<=10;i++){
			var rd = Math.floor(Math.random() * (tmpJudge.length));
			tmpJudge[rd].questionType = 2;
			result.push(tmpJudge[rd]);
		}
		//论述
		var tmpDiscuss = await DiscussQuestion.find({
			'question.category.categoryId': req.query["id"]
		}).lean();
		for(var i=1;i<=10;i++){
			var rd = Math.floor(Math.random() * (tmpDiscuss.length));
			tmpDiscuss[rd].questionType=3;
			result.push(tmpDiscuss[rd]);
		}
		


		/* var item = await Exam.findById(req.query["id"]);
		for (var question of item.questions) {
			if (question.questionType == 0) {
				question.detail = await ChoiceQuestion.findById(question.questionId);
			} else if (question.questionType == 1) {
				question.detail = await MultipleChoiceQuestion.findById(question.questionId);
			} else if (question.questionType == 2) {
				question.detail = await JudgedQuestion.findById(question.questionId);
			} else if (question.questionType == 3) {
				question.detail = await DiscussQuestion.findById(question.questionId);
			}
		} */
		// 发回客户端
		res.send(result)
	})


	// 路由挂载
	app.use('/web/api/exam', router)
}
