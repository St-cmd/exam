const express = require('express')
// 1.注册核心主路由--创建express实例
const app = express()
app.use(require('cors')())
app.use(express.json())
// 托管静态文件
app.use('/upload', express.static(__dirname + '/upload'))

// 引用后端路由-并执行
require('./routes/admin/category')(app)
require('./routes/admin/admininfo')(app)
require('./routes/admin/choicequestion')(app)
require('./routes/admin/multiplechoicequestion')(app)
require('./routes/admin/judgedquestion')(app)
require('./routes/admin/discussquestion')(app)
require('./routes/admin/file')(app)
require('./routes/admin/login')(app)
// 前端路由
require('./routes/web/wrongquestion')(app)
require('./routes/web/category')(app)
require('./routes/web/choicequestion')(app)
require('./routes/web/judgedquestion')(app)
require('./routes/web/multiplechoicequestion')(app)
require('./routes/web/discussquestion')(app)
require('./routes/web/userinfo')(app)
require('./routes/web/exam')(app)

// 引入数据库
require('./plugins/db')(app)

app.listen(6500, () => {
    console.log("server端启动，BackStage，http://localhost:6500")
})