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
            <el-dropdown-item command="多选题">多选题</el-dropdown-item>
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
                  Ai === item.answer
                    ? 'green'
                    : actionData[index] == Ai
                    ? 'pink'
                    : '',
              }">
              {{ option[Ai] }}
            </div>
            {{ Aitem }}
          </div>
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
        name: '单选题',
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
      // 返回
      ClickBack() {
        this.$router.push('/user')
      },
      // 点击切换题目类型
      handleCommand(command) {
        // this.name=command
        this.nam = command
        switch (command) {
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
      // 标记题目对错
      action(index, Ai) {
        // 点击的时候将点击的选项记录下来
        this.$set(this.actionData, index, Ai);
        // 保存正确选项
        let Ar = this.question[index].right;
        // 点击时，将正确选项存到题目属性中
        this.question[index].answer = Ar;
        if (Ai.toString() === Ar.toString()) {
          let result = this.wrongQuestion.indexOf(this.question[index]);
          if (result >= 0) {
            this.wrongQuestion.splice(result, 1);
            this.Wrong--;
          } else {}
          let res = this.correctQuestion.indexOf(this.question[index]);
          if (res > 0) {} else {
            this.Correct++;
            let temp = this.question[index];
            temp.username = this.username;
            this.correctQuestion.push(temp);
          }
        } else {
          let result = this.wrongQuestion.indexOf(this.question[index]);
          if (result >= 0) {} else {
            this.Wrong += 1;
            // 保存错题--将错误题目保存到数组中
            let temp = this.question[index];
            temp.username = this.username;
            this.wrongQuestion.push(temp);
          }
          let res = this.correctQuestion.indexOf(this.question[index]);
          if (res >= 0) {
            this.Correct--;
            this.correctQuestion.splice(result, 1);
          } else {}
        }
      },
      // 获取题目
      async getQuestion() {
        // 如果有id,则按照分类id取
        let res;
        // 分类练习
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
              `/choiceQuestion/${categoryRes.data.pre}`
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
          res = await this.$http.get(`/choiceQuestion/${this.$route.params.id}`);
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
              "questionId": categoryData[i]._id
            };
            this.question.push(qObj);
          }
        } else if (this.$route.params.wid) {
          this.is_wrong = true;
          // 错题
          res = await this.$http.get(`/wrongquestion`, {
            "params": {
              "username": this.username,
              "categoryId": this.$route.params.wid,
              "questionType": 0
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
              "questionId": categoryData[i]._id
            };
            this.question.push(qObj);
          }
        } else {
          // 随机练习
          // 直接获取选择题
          res = await this.$http.get("/choiceQuestion");
          let random = res.data;
          // 将获取到的题目数组进行随机
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
              "questionId":item.questionId
            };
            this.question.push(qObj);
          });
        }
      },
      // 保存错题到服务器
      async postWrongQuestion() {
        let res = await this.$http.post("/wrongquestion", this.wrongQuestion);
      },
      // 高频错题
      async wrongQuestionHigh() {
        await this.$http.get("/choiceQuestion").then((res) => {
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
                category
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
                category
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
                category
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
      background-color: #fff;
      height: 100vh;

      .box {
        background: #fff;
        float: left;
        box-sizing: border-box;
        overflow: auto;
        padding: 30px 30px;

        .list {
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

          .right {
            background: green;
          }

          .wrong {
            background: pink;
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
