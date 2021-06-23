<template>
  <div class="Reprint">
    <div class="wrap">
      <div class="Img"><img src="@/assets/images/Header/back.png" alt @click="ClickBack" /></div>
      <div class="box">
        <el-dropdown @command="handleCommand">
          <span class="el-dropdown-link">
            {{name}}
            <i class="el-icon-arrow-down el-icon--right"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="单选题">单选题</el-dropdown-item>
            <el-dropdown-item command="判断题">判断题</el-dropdown-item>
            <el-dropdown-item command="多选题">多选题</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </div>
    <div class="container" :style="{
          width: screenWidth * question.length + 'px',
          left: -(pageNum * screenWidth) + 'px'
        }" @touchstart="touchStart" @touchend="touchEnd">
      <div class="box" :style="{ width: screenWidth + 'px' }" v-for="(item, index) in question" :key="index">
        {{ item.title }}
        <textarea class="inp" name="" id="" v-model="item.txt"></textarea>
        <el-button class="btn" type="primary" plain @click="showAnswer(index)">点击显示答案</el-button>

        <div class="rightAnswer" v-if="item.isShow">
          {{ item.rightAnswer }}
        </div>
      </div>
    </div>

    <footer>
      <div>
        <img src="@/assets/images/Reprint/Quantity.png" alt />
        {{ pageNum +1 }}/{{ question.length }}
      </div>
    </footer>
  </div>
</template>

<script>
  import {
    shuffle
  } from '../../common/utils'

  export default {
    props: {
      id: {}
    },
    data() {
      return {
        name: '论述题',
        question: [],
        windowHeight: '',
        screenWidth: document.body.clientWidth, // 屏幕尺寸
        pageNum: 0, // 第几题
        correctQuestion: [], // 保存正确的题目
        wrongQuestion: [], // 保存错题
        move: {
          start: '',
          end: ''
        },
        actionRight: '',
        wrongdataArr: [],
        username: '', // 用户名
        is_wrong: false
      }
    },
    beforeDestroy() {
      if (this.wrongQuestion.length !== 0 || this.correctQuestion !== 0) {
        if (this.is_wrong) return;
        this.postWrongQuestion()
      }
    },
    created() {
      // 如果有id,则按照分类id取数据
      this.username = this.getCookie('username')
      this.getQuestion()
      // this.params.id && getRecomandQuestion()
      this.id && this.wrongQuestionHigh()

    },
    // 钩子函数
    mounted() {
      const that = this
      window.onresize = () => {
        return (() => {
          window.screenWidth = document.body.clientWidth
          that.screenWidth = window.screenWidth
        })()
      }
    },
    methods: {
      ClickBack() {
        this.$router.push('/user')
      },
      // 点击切换题目类型
      handleCommand(command) {
        // this.name=command
        this.nam = command;
        switch (command) {
          case '单选题':
            if (this.is_wrong) {
              this.$router.push(`/ChoiceQuestion/Wrong/${this.$route.params.wid}`)
            } else {
              if (this.$route.params.id && typeof this.$route.params.id === "string") {
                this.$router.push(`/ChoiceQuestion/${this.$route.params.id}`)
              } else {
                this.$router.push(`/ChoiceQuestion`)
              }
            }
            break;
          case '多选题':
            if (this.is_wrong) {
              this.$router.push(`/MultiplechoiceQuestion/Wrong/${this.$route.params.wid}`)
            } else {
              if (this.$route.params.id && typeof this.$route.params.id === "string") {
                this.$router.push(`/MultiplechoiceQuestion/${this.$route.params.id}`)
              } else {
                this.$router.push(`/MultiplechoiceQuestion`)
              }
            }
            break;
          case '判断题':
            if (this.is_wrong) {
              this.$router.push(`/JudgedQuestion/Wrong/${this.$route.params.wid}`)
            } else {
              if (this.$route.params.id && typeof this.$route.params.id === "string") {
                this.$router.push(`/JudgedQuestion/${this.$route.params.id}`)
              } else {
                this.$router.push(`/JudgedQuestion`)
              }
            }
            break
        }

      },
      //   点击显示答案
      showAnswer(index) {
        if (!Boolean(this.question[index].txt)) {
          this.question[index].isShow = false
          this.$message({
            message: '请在该题作答之后查看答案！',
            type: 'info'
          });
          return;
        }
        this.question[index].isShow = !Boolean(this.question[index].isShow)
        this.question[index].username = this.username;
        this.wrongQuestion.push(this.question[index]);
      },
      // 获取当前用户名
      getCookie(name) {
        var arr = document.cookie.match(
          new RegExp('(^| )' + name + '=([^;]*)(;|$)')
        )
        if (arr != null) {
          return unescape(arr[2])
        }
        return null
      },
      // 滑屏翻页
      touchStart(e) {
        this.move.start = e.touches[0].clientX
      },
      touchEnd(e) {
        let end = e.changedTouches[0].pageX
        // if (this.list[this.pageNum].newType != 'saqs'||)
        if (this.move.start - end >= 50) {
          if (this.pageNum + 1 < this.question.length) {
            this.pageNum += 1;
          } else {
            this.$message({
              message: '没有更多题了哦~~',
              type: 'info'
            });
          }
        }
        if (this.move.start - end <= -50) {
          if (this.pageNum !== 0) {
            this.pageNum -= 1;
          } else {
            this.$message({
              message: '已经到第一题了哦~~',
              type: 'info'
            });
          }
        }
      },
      // 获取题目
      async getQuestion() {
        // 如果有id,则按照分类id取
        let res
        // 同类推荐
        if (this.$route.params.id && typeof(this.$route.params.id) === 'string') {
          /**
           * 获取前置分类题目数据
           */
          // 根据类型id获取到分类的值
          const categoryRes = await this.$http.get(`/category/${this.$route.params.id}`)
          // 如果分类的前置分类id存在，则根据前置分类id获取题目
          if (categoryRes.data.pre) {
            const categoryPreRes = await this.$http.get(`/discussquestion/${categoryRes.data.pre}`)
            const preData = categoryPreRes.data
            // 将前置分类的题目放入question数组中
            preData.forEach(item => {
              item.question.isShow = false
              this.question.push(item.question)
            })
          }
          /**
           * 获取这一分类的题目数据，放入数组中
           */
          res = await this.$http.get(`/discussquestion/${this.$route.params.id}`)
          const categoryData = res.data
          categoryData.forEach(item => {
            item.question.isShow = false;
            item.question.questionId = item._id;
            this.question.push(item.question)
          })
        } else if (this.$route.params.wid) {
          this.is_wrong = true;
          // 错题
          res = await this.$http.get(`/wrongquestion`, {
            "params": {
              "username": this.username,
              "categoryId": this.$route.params.wid,
              "questionType": 3
            }
          });
          const categoryData = res.data
          categoryData.forEach(item => {
            item.question.isShow = false;
            item.question.questionId = item._id;
            this.question.push(item.question)
          })

        } else {
          // 直接获取论述题
          res = await this.$http.get('/discussquestion')
          let random = res.data
          let randomArr = shuffle(random)
          // 形成题目数组
          randomArr.forEach(item => {
            item.question.isShow = false;
            item.question.questionId = item._id;
            this.question.push(item.question)
          })
        }
      },
      // 保存错题到服务器
      async postWrongQuestion() {
        let res = await this.$http.post("/wrongquestion", this.wrongQuestion);
      },
      async wrongQuestionHigh() {
        await this.$http.get('/discussquestion').then(res => {
          res.data.forEach(item =>
            this.wrongdataArr.push(item.question)
          )

          if (this.$route.params.id === '1') {
            // id:1
            let rateOne = this.wrongdataArr.filter(item => {
              return item.rate < 3
            })
            rateOne.forEach(item => {
              let title = item.title;
              let answerList = [
                item.answerA,
                item.answerB,
                item.answerC,
                item.answerD,
              ]; // 答案数组
              let rate = item.rate;
              let right = item.rightAnswer;
              let category = item.category;
              let qObj = {
                title,
                answerList,
                rate,
                right,
                category
              };
              this.question.push(qObj)
            })
          } else if (this.id === '2') {
            // id:2
            let rateTwo = this.wrongdataArr.filter(item => {
              return item.rate < 4 && item.rate >= 3
            })
            rateTwo.forEach(item => {
              let title = item.title;
              let answerList = [
                item.answerA,
                item.answerB,
                item.answerC,
                item.answerD,
              ]; // 答案数组
              let rate = item.rate;
              let right = item.rightAnswer;
              let category = item.category;
              let qObj = {
                title,
                answerList,
                rate,
                right,
                category
              };
              this.question.push(qObj)
            })
          } else if (this.id === '3') {
            // id:3
            let rateThree = this.wrongdataArr.filter(item => {
              return item.rate <= 5 && item.rate >= 4
            })
            rateThree.forEach(item => {
              let title = item.title;
              let answerList = [
                item.answerA,
                item.answerB,
                item.answerC,
                item.answerD,
              ]; // 答案数组
              let rate = item.rate;
              let right = item.rightAnswer;
              let category = item.category;
              let qObj = {
                title,
                answerList,
                rate,
                right,
                category
              };
              this.question.push(qObj)
            })
          }
        })
      }
    }
  }
</script>

<style lang="less" scoped>
  .Reprint {
    .wrap {
      height: 60px;
      display: flex;
      align-items: center;

      .Img {
        width: 24px;
        height: 24px;

        img {
          width: 24px;
          height: 24px;
        }
      }

      .box {
        flex: 1;
        text-align: center;

        .el-dropdown-link {
          font-size: 20px;
          cursor: pointer;
          color: #409eff;
          display: flex;
        }

        .el-icon-arrow-down {
          font-size: 20px;
          margin-top: 6px;
        }
      }

    }

    .container {
      height: 100%;
      background: #fff;
      position: fixed;
      overflow-y: auto;
      overflow-x: hidden;
      transition: left 0.5s;
      height: 100vh;

      .box {
        background: #fff;
        float: left;
        box-sizing: border-box;
        overflow: auto;
        padding: 30px 30px;

        .inp {
          margin-top: 20px;
          margin-left: 2px;
          width: 300px;
          height: 200px;
          resize: none;
        }

        .btn {
          margin: 10px auto;
        }

        .rightAnswer {
          width: 100%;
          margin-bottom: 120px;

        }
      }
    }

    footer {
      position: fixed;
      bottom: 0;
      left: 0;
      display: flex;
      width: 100vw;
      height: 60px;
      align-items: center;
      justify-content: center;
      text-align: center;
      background: #fff;

      div {
        width: 35%;
        display: flex;
        justify-content: center;
        align-items: center;
      }

      img {
        width: 30px;
        height: 30px;
        margin-right: 10px;
      }
    }
  }
</style>
