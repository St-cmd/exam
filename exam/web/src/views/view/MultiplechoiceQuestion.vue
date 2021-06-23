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
            <el-dropdown-item command="论述题">论述题</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>
    </div>
    <div class="container" :style="{
        width: screenWidth * question.length + 'px',
        left: -(pageNum * screenWidth) + 'px',
      }" @touchstart="touchStart" @touchend="touchEnd">
      <div class="box" :style="{ width: screenWidth + 'px' }" v-for="(item, index) in question" :key="index">
        {{ item.title }}
        <div class="list">
          <div class="list-demo" v-for="(Aitem, Ai) in item.answerList" :key="Ai" @click="action(index, Ai)">
            <div class="option" :style="{
                background:
                  actionData[index] instanceof Array &&
                  actionData[index].indexOf(Ai) >= 0
                    ? 'lightskyblue'
                    : '',
              }">
              {{ option[Ai] }}
            </div>
            {{ Aitem }}
          </div>
        </div>
        <div class="answ" v-if="item.flag == true">
          <span class="user">你的答案：<i :style="{
                color: Boolean(question[index].isRight)
                  ? 'rgb(14, 148, 231)'
                  : 'rgb(248, 69, 45)',
              }">{{ item.userAnswerStr }}</i></span>
          <span class="correct">正确答案：<i>{{ item.rightStr }}</i></span>
        </div>
      </div>
    </div>

    <footer>
      <!-- <div>
        <img src="@/assets/images/Reprint/Favorite.png" alt />
        收藏
      </div>-->
      <div>
        <img src="@/assets/images/Reprint/Correct.png" alt />
        {{ Correct }}
      </div>
      <div>
        <img src="@/assets/images/Reprint/Wrong.png" alt />
        {{ Wrong }}
      </div>
      <div>
        <img src="@/assets/images/Reprint/Quantity.png" alt />
        {{ pageNum + 1 }}/{{ question.length }}
      </div>
    </footer>
  </div>
</template>

<script>
  import {
    shuffle
  } from "../../common/utils";

  export default {
    props: {
      id: {},
    },
    data() {
      return {
        name: '多选题',
        actionData: [], // 储存选中选项
        question: [],
        windowHeight: "",
        screenWidth: document.body.clientWidth, // 屏幕尺寸
        option: ["A", "B", "C", "D"],
        pageNum: 0, // 第几题
        Correct: 0, // 对题数量
        Wrong: 0, // 错题数量
        correctQuestion: [], // 保存正确的题目
        wrongQuestion: [], // 保存错题
        move: {
          start: "",
          end: "",
        },
        actionRight: "",
        RecomandArr: [], // 同类推荐题目数组
        wrongdataArr: [],
        username: "", // 用户名
        is_wrong: false
      };
    },
    beforeDestroy() {
      if (this.wrongQuestion.length !== 0 || this.correctQuestion !== 0) {
        if (this.is_wrong) return;
        this.postWrongQuestion();
      }
    },
    created() {
      // 如果有id,则按照分类id取数据
      this.username = this.getCookie("username");
      this.getQuestion();
      // this.params.id && getRecomandQuestion()
      this.id && this.wrongQuestionHigh();
    },
    // 钩子函数
    mounted() {
      const that = this;
      window.onresize = () => {
        return (() => {
          window.screenWidth = document.body.clientWidth;
          that.screenWidth = window.screenWidth;
        })();
      };
    },
    methods: {
      ClickBack() {
        this.$router.push('/user')
      },
      // 点击切换题目类型
      handleCommand(command) {
        // this.name=command
        this.nam = command
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
          case '论述题':
            if (this.is_wrong) {
              this.$router.push(`/DiscussQuestion/Wrong/${this.$route.params.wid}`)
            } else {
              if (this.$route.params.id && typeof this.$route.params.id === "string") {
                this.$router.push(`/DiscussQuestion/${this.$route.params.id}`)
              } else {
                this.$router.push(`/DiscussQuestion`)
              }
            }
            break
        }

      },
      // 获取当前用户名
      getCookie(name) {
        var arr = document.cookie.match(
          new RegExp("(^| )" + name + "=([^;]*)(;|$)")
        );
        if (arr != null) {
          return unescape(arr[2]);
        }
        return null;
      },
      // 滑屏翻页
      touchStart(e) {
        this.move.start = e.touches[0].clientX;
      },
      touchEnd(e) {
        let end = e.changedTouches[0].pageX;
        // if (this.list[this.pageNum].newType != 'saqs'||)
        if (this.move.start - end >= 50) {
          // 在滑动，布尔值变为this.question[this.pageNum].flag=true
          // 用户选择的答案this.actionData[this.pageNum]
          // 标准答案 this.question[this.pageNum].right
          // 比对逻辑：先判断答案长度是否一致，不一致则为错误，提示用户(显示用户所选答案和标准答案)并阻止翻页this.pageNum值不变
          // 若为一致，则比较内容是否一致，遍历用户选择的答案是否都在 标准答案中存在indexOf
          // 只要有一个不存在，则判定为错误，提示用户(显示用户所选答案和标准答案)并阻止翻页
          // 都存在则 显示用户所选答案和标准答案;this.pageNum += 1
          if (this.question[this.pageNum].flag == false) {
            // 用户选择的答案
            let userAnswer = this.actionData[this.pageNum];
            // 标准答案
            let rightAnswer = this.question[this.pageNum].right;
            // 页面显示答案信息
            // 用户答案
            let userAnswerArr = [];
            if (userAnswer instanceof Array && userAnswer.length > 0) {
              userAnswer.sort().forEach((item) => {
                userAnswerArr.push(this.option[item]);
              });
              this.question[this.pageNum].userAnswerStr = userAnswerArr.join(",");
            } else {
              this.question[this.pageNum].userAnswerStr = "未作答";
            }

            // 标准答案
            this.question[this.pageNum].rightStr = rightAnswer.sort().join(",");
            this.question[this.pageNum].flag = true;

            if (
              userAnswer instanceof Array &&
              userAnswer.length == rightAnswer.length
            ) {
              // 长度一致，比对内容
              let isWrong = false;
              userAnswer.forEach((item) => {
                if (rightAnswer.indexOf(this.option[item]) == -1) {
                  isWrong = true;
                  return;
                }
              });
              if (isWrong) {
                //判断是在wrongQuestion中，不在则记录到答错题列表 wrongQuestion
                this.collectWrongQuestion(this.pageNum);
              } else {
                // 答案正确，判断是否记录到
                this.collectCorrectQuestion(this.pageNum);
                if (this.pageNum + 1 < this.question.length) {
                  this.pageNum += 1;
                } else {
                  this.$message({
                    message: "没有更多题了哦~~",
                    type: "info",
                  });
                }
              }
            } else {
              //记录到答错题列表 wrongQuestion
              this.collectWrongQuestion(this.pageNum);
            }
          } else {
            // 做过
            if (this.pageNum + 1 < this.question.length) {
              this.pageNum += 1;
            } else {
              this.$message({
                message: "没有更多题了哦~~",
                type: "info",
              });
            }
          }
        }
        if (this.move.start - end <= -50) {
          if (this.pageNum !== 0) {
            this.pageNum -= 1;
          } else {
            this.$message({
              message: "已经到第一题了哦~~",
              type: "info",
            });
          }
        }
      },
      // 将用户所选题目存储
      action(index, Ai) {
        // 点击的时候将点击的选项记录下来
        if (!this.question[index].flag) {
          if (!(this.actionData[index] instanceof Array)) {
            this.actionData[index] = [];
          }
          let userAnwser = this.actionData[index];
          let i = userAnwser.indexOf(Ai);
          if (i >= 0) {
            // 存在，则为取消勾选， 移除响应答案
            userAnwser.splice(i, 1);
          } else {
            // 不存在，存储用户答案
            userAnwser.push(Ai);
          }
          this.$set(this.actionData, index, userAnwser);
        }
      },
      // 获取题目
      async getQuestion() {
        // 如果有id,则按照分类id取
        let res;
        // 同类推荐
        if (this.$route.params.id && typeof this.$route.params.id === "string") {
          /**
           * 获取前置分类题目数据
           */
          // 根据类型id获取到分类的值
          const categoryRes = await this.$http.get(
            `/category/${this.$route.params.id}`
          );
          // 如果分类的前置分类id存在，则根据前置分类id获取题目
          if (categoryRes.data.pre) {
            const categoryPreRes = await this.$http.get(
              `/multiplechoicequestion/${categoryRes.data.pre}`
            );
            const preData = categoryPreRes.data;
            // 将前置分类的题目放入question数组中
            preData.forEach((item) => {
              this.RecomandArr.push(item.question);
            });
          }
          /**
           * 获取这一分类的题目数据，放入数组中
           */
          res = await this.$http.get(
            `/multiplechoicequestion/${this.$route.params.id}`
          );
          const categoryData = res.data;
          categoryData.forEach((item) => {
            this.RecomandArr.push(item.question);
          });

          /**
           * 整理question数组
           */
          for (var i = 0; i < this.RecomandArr.length; i++) {
            var item = this.RecomandArr[i];
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
            // 定义一个变量，flag=false，在获取当前题目时在数组选项组中添加一个标识设置为false
            let flag = false;
            let isRight = false;
            // 将正确答案的ABCD转化为0123
            switch (right) {
              case "A":
                right = 0;
                break;
              case "B":
                right = 1;
                break;
              case "C":
                right = 2;
                break;
              case "D":
                right = 3;
                break;
            }
            let qObj = {
              title,
              answerList,
              rate,
              right,
              category,
              flag,
              isRight,
              "questionId": categoryData[i]._id
            };
            this.question.push(qObj);
          }
          console.log(this.question);
        } else if (this.$route.params.wid) {
          this.is_wrong = true;
          // 错题
          res = await this.$http.get(`/wrongquestion`, {
            "params": {
              "username": this.username,
              "categoryId": this.$route.params.wid,
              "questionType": 1
            }
          });
          const categoryData = res.data;
          categoryData.forEach((item) => {
            this.RecomandArr.push(item.question);
          });

          /**
           * 整理question数组
           */
          for (var i = 0; i < this.RecomandArr.length; i++) {
            var item = this.RecomandArr[i];
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
            // 定义一个变量，flag=false，在获取当前题目时在数组选项组中添加一个标识设置为false
            let flag = false;
            let isRight = false;
            // 将正确答案的ABCD转化为0123
            switch (right) {
              case "A":
                right = 0;
                break;
              case "B":
                right = 1;
                break;
              case "C":
                right = 2;
                break;
              case "D":
                right = 3;
                break;
            }
            let qObj = {
              title,
              answerList,
              rate,
              right,
              category,
              flag,
              isRight,
              "questionId": categoryData[i]._id
            };
            this.question.push(qObj);
          }
        } else {
          // 直接获取选择题
          res = await this.$http.get("/multiplechoicequestion");
          let random = res.data;
          let randomArr = shuffle(random);
          // 形成题目数组
          let arr = [];
          randomArr.forEach((item) => {
            item.question.questionId=item._id;
            arr.push(item.question);
          });
          // 整理question数组格式
          arr.forEach((item) => {
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
            let flag = false;
            let isRight = false;
            // 将正确答案的ABCD转化为0123
            switch (right) {
              case "A":
                right = 0;
                break;
              case "B":
                right = 1;
                break;
              case "C":
                right = 2;
                break;
              case "D":
                right = 3;
                break;
            }
            let qObj = {
              title,
              answerList,
              rate,
              right,
              category,
              flag,
              isRight,
              "questionId":item.questionId
            };
            this.question.push(qObj);
          });
        }
      },
      // 存储错误题目
      collectWrongQuestion(index) {
        this.Wrong += 1;
        let temp = this.question[index];
        temp.username = this.username;
        this.wrongQuestion.push(temp);
      },
      // 存储正确题目
      collectCorrectQuestion(index) {
        this.question[index].isRight = true;
        this.Correct++;
        let temp = this.question[index];
        temp.username = this.username;
        this.correctQuestion.push(temp);
      },
      // 保存错题到服务器
      async postWrongQuestion() {
        let res = await this.$http.post("/wrongquestion", this.wrongQuestion);
      },
      async wrongQuestionHigh() {
        await this.$http.get("/multiplechoicequestion").then((res) => {
          res.data.forEach((item) => this.wrongdataArr.push(item.question));

          if (this.$route.params.id === "1") {
            // id:1
            let rateOne = this.wrongdataArr.filter((item) => {
              return item.rate < 3;
            });
            rateOne.forEach((item) => {
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
              let flag = false; //判断是否做过此题
              let isRight = false; //判断用户所选答案是否正确
              // 将正确答案的ABCD转化为0123
              switch (right) {
                case "A":
                  right = 0;
                  break;
                case "B":
                  right = 1;
                  break;
                case "C":
                  right = 2;
                  break;
                case "D":
                  right = 3;
                  break;
              }
              let qObj = {
                title,
                answerList,
                rate,
                right,
                category,
                flag,
                isRight,
              };
              this.question.push(qObj);
            });
          } else if (this.id === "2") {
            // id:2
            let rateTwo = this.wrongdataArr.filter((item) => {
              return item.rate < 4 && item.rate >= 3;
            });
            rateTwo.forEach((item) => {
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
              let flag = false;
              let isRight = false;
              // 将正确答案的ABCD转化为0123
              switch (right) {
                case "A":
                  right = 0;
                  break;
                case "B":
                  right = 1;
                  break;
                case "C":
                  right = 2;
                  break;
                case "D":
                  right = 3;
                  break;
              }
              let qObj = {
                title,
                answerList,
                rate,
                right,
                category,
                flag,
                isRight,
              };
              this.question.push(qObj);
            });
          } else if (this.id === "3") {
            // id:3
            let rateThree = this.wrongdataArr.filter((item) => {
              return item.rate <= 5 && item.rate >= 4;
            });
            rateThree.forEach((item) => {
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
              let flag = false;
              let isRight = false;
              // 将正确答案的ABCD转化为0123
              switch (right) {
                case "A":
                  right = 0;
                  break;
                case "B":
                  right = 1;
                  break;
                case "C":
                  right = 2;
                  break;
                case "D":
                  right = 3;
                  break;
              }
              let qObj = {
                title,
                answerList,
                rate,
                right,
                category,
                flag,
                isRight,
              };
              this.question.push(qObj);
            });
          }
        });
      },
    },
  };
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

    .content {
      position: fixed;
      overflow-y: auto;
      overflow-x: hidden;
      transition: left 0.5s;

      .question {
        background: #fff;
        float: left;
        box-sizing: border-box;
        overflow: auto;
        padding: 30px 30px;
        height: 100vh;
        width: 100vw;

        .title {
          padding: 15px;
          font-size: 18px;
        }

        .answerlist {
          padding: 15px;

          .list-demo {
            display: flex;
            padding: 10px;
            align-items: center;

            .option {
              width: 35px;
              height: 35px;
              border: 1px solid #000;
              border-radius: 50%;
              text-align: center;
              line-height: 35px;
            }

            .answer {
              padding-left: 15px;
              font-size: 18px;
            }
          }
        }
      }
    }
  }

  .Reprint {
    .container {
      position: fixed;
      overflow-y: auto;
      overflow-x: hidden;
      transition: left 0.5s;
      background-color: #f1f0f5;
      height: 100vh;

      .box {
        height: 100%;
        background: #fff;
        float: left;
        box-sizing: border-box;
        overflow: auto;
        padding: 30px 30px;

        .list {
          margin-bottom: 50px;

          .list-demo {
            display: flex;
            align-items: center;
            margin-top: 25px;
          }

          .option {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            border: 1px solid #dbdbdb;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-right: 20px;
          }

          // .right {
          //   background: green;
          // }
          // .wrong {
          //   // background: pink;

          // }
        }

        .answ {
          font-size: 18px;
          font-weight: bold;

          display: flex;
          flex-direction: column;
          justify-content: space-between;

          .user {
            display: inline-block;
            margin-bottom: 10px;

            i {
              font-style: normal;
              //  color: rgb(248, 69, 45);
            }

            //  .blue{
            //    color: rgb(14, 148, 231);
            //  }
            //  .orange{
            //    color: rgb(248, 69, 45);
            //  }
          }

          .correct {
            i {
              font-style: normal;
              color: rgb(14, 148, 231);
            }
          }
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
