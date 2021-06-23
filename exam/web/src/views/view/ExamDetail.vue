<template>
  <div class="Reprint" v-if="exam_detail!=null">
    <div class="wrap">
      <div class="Img"><img src="@/assets/images/Header/back.png" alt @click="ClickBack" /></div>
      <div class="box">
        <h2>{{exam_detail[0].question.category.categoryName}}</h2>
      </div>
    </div>
    <div class="container" v-if="show_result" :style="'width:'+screenWidth+'px;'"
      style="display: flex;flex-direction: column;justify-content: center;text-align: center;">
      <div>
        <h2>本次考试正确率</h2>
        <h2>单选题 {{rate[0].right}}/{{rate[0].sum}}</h2>
        <h2>多选题 {{rate[1].right}}/{{rate[1].sum}}</h2>
        <h2>判断题 {{rate[2].right}}/{{rate[2].sum}}</h2>
        <h2>论述题 {{rate[3].right}}/{{rate[3].sum}}</h2>
      </div>
    </div>
    <div class="container" v-if="!show_result" :style="{
        width: screenWidth * exam_detail.length + 'px',
        left: -(pageNum * screenWidth) + 'px',
      }" @touchstart="touchStart" @touchend="touchEnd">
      <div class="box" :style="{ width: screenWidth + 'px' }" v-for="(item, index) in exam_detail" :key="index">
        <div>({{question_name[item.questionType]}})</div>
        <div v-if="item.questionType==0">
          {{ item.question.title }}
          <div class="list">
            <div class="list-demo" v-for="(Aitem, Ai) in item.question.answers" :key="Ai"
              @click="chooseChoiceQuestion(index, Ai)">
              <div class="option" :style="{
                  background:is_submit?(item.question.rightAnswer==Ai?'#67C23A':(user_answer[index]==Ai?'#F56C6C':'')):(user_answer[index]==Ai?'#409eff':'')
                }">
                {{ option[Ai] }}
              </div>
              {{ Aitem }}
            </div>
          </div>
        </div>

        <div v-if="item.questionType==1">
          {{ item.question.title }}
          <div class="list">
            <div class="list-demo" v-for="(Aitem, Ai) in item.question.answers" :key="Ai"
              @click="chooseMultQuestion(index, Ai)">
              <div class="option" :style="{
                  background:
                  (user_answer[index] instanceof Array && user_answer[index].indexOf(Ai)!=-1)?'#409eff':''
                }">
                {{ option[Ai] }}
              </div>
              {{ Aitem }}
            </div>
          </div>
          <div class="answ" v-if="is_submit">
            <div class="user">你的答案：<i :style="{
                  color: (item.question.isRight)
                    ? '#67C23A'
                    : '#F56C6C',
                }">{{ item.question.userAnswerStr }}</i></div>
            <div class="correct">正确答案：<i>{{ item.question.answerStr }}</i></div>
          </div>
        </div>

        <div v-if="item.questionType==2">
          {{ item.question.title }}
          <div class="list">
            <div class="list-demo" v-for="(Aitem, Ai) in item.question.answers" :key="Ai"
              @click="chooseJudge(index, Ai)">
              <div class="option" :style="{
                  background:is_submit?(item.question.rightAnswer==Ai?'#67C23A':(user_answer[index]==Ai?'#F56C6C':'')):(user_answer[index]==Ai?'#409eff':'')
                }">
                {{ option[Ai] }}
              </div>
              {{ Aitem }}
            </div>
          </div>
        </div>

        <div v-if="item.questionType==3">
          {{ item.question.title }}
          <textarea class="inp" name="" id="" v-model="item.question.txt"></textarea>
          <div class="rightAnswer" v-if="is_submit">
            <div>正确答案：</div>
            {{ item.question.rightAnswer }}
          </div>
        </div>

      </div>

    </div>

    <footer>
      <div>
        <img src="@/assets/images/Reprint/Quantity.png" alt />
        {{ pageNum + 1 }}/{{ exam_detail.length }}
      </div>
      <div>
        <el-button type="primary" round style="width: 80%;" @click="submit">
          {{is_submit?(show_result?"查看错题":"查看得分"):"提交"}}
        </el-button>
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
        exam_detail: null,//总题目
        question_name: ["单选题", "多选题", "判断题", "论述题"],
        question: [],
        screenWidth: document.body.clientWidth, // 屏幕尺寸
        option: ["A", "B", "C", "D"],
        pageNum: 0, // 第几题
        move: {
          start: "",
          end: "",
        },
        is_submit: false,
        user_answer: [],
        show_result: false,
        rate: [{
          "right": 0,
          "sum": 0
        }, {
          "right": 0,
          "sum": 0
        }, {
          "right": 0,
          "sum": 0
        }, {
          "right": 0,
          "sum": 0
        }]
      };
    },
    beforeDestroy() {},
    created() {
      this.getExamDetail();
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
      async getExamDetail() {
        const res = await this.$http.get('/exam/detail', {
          params: {
            id: this.$route.params.id
          }
        });
        console.log(res);
        
        this.exam_detail = res.data;
        this.user_answer = new Array(this.exam_detail.length);
        for (var detail of this.exam_detail) {
          // 单选
          if (detail.questionType == 0) {
            detail.question.answers = [detail.question.answerA, detail.question.answerB, detail.question.answerC,
              detail.question.answerD
            ];
            switch (detail.question.rightAnswer) {
              case "A":
                detail.question.rightAnswer = 0;
                break;
              case "B":
                detail.question.rightAnswer = 1;
                break;
              case "C":
                detail.question.rightAnswer = 2;
                break;
              case "D":
                detail.question.rightAnswer = 3;
                break;
            }
          } else if (detail.questionType == 1) {
            // 多选
            detail.question.answers = [detail.question.answerA, detail.question.answerB, detail.question.answerC,
              detail.question.answerD
            ];
            detail.question.isRight = false;
            detail.question.userAnswerStr = "";
            detail.question.answerStr = "";
            for (var i = 0; i < detail.question.rightAnswer.length; i++) {
              detail.question.answerStr += detail.question.rightAnswer[i] + ",";
              switch (detail.question.rightAnswer[i]) {
                case "A":
                  detail.question.rightAnswer[i] = 0;
                  break;
                case "B":
                  detail.question.rightAnswer[i] = 1;
                  break;
                case "C":
                  detail.question.rightAnswer[i] = 2;
                  break;
                case "D":
                  detail.question.rightAnswer[i] = 3;
                  break;
              }
            }
            detail.question.answerStr = detail.question.answerStr.substr(0, detail.question.answerStr.length - 1);
          } else if (detail.questionType == 2) {
            // 判断
            detail.question.answers = ["正确", "错误"];
            detail.question.rightAnswer = (detail.question.rightAnswer == "A" ? 0 : 1);
          }
        }
      },
      chooseChoiceQuestion(question_index, option_index) {
        if (this.is_submit) return;
        this.$set(this.user_answer, question_index, option_index);
      },
      chooseMultQuestion(question_index, option_index) {
        if (this.is_submit) return;
        if (this.user_answer[question_index] == null) {
          this.$set(this.user_answer, question_index, [option_index]);
        } else {
          var index = this.user_answer[question_index].indexOf(option_index);
          if (index == -1) {
            this.user_answer[question_index].push(option_index);
          } else {
            this.user_answer[question_index].splice(index, 1);
          }
        }
        //设置userAnswerStr
        this.exam_detail[question_index].question.userAnswerStr = "";
        for (var i = 0; i < 4; i++) {
          for (var answer of this.user_answer[question_index]) {
            if (answer == i) {
              switch (i) {
                case 0:
                  this.exam_detail[question_index].question.userAnswerStr += "A,";
                  break;
                case 1:
                  this.exam_detail[question_index].question.userAnswerStr += "B,";
                  break;
                case 2:
                  this.exam_detail[question_index].question.userAnswerStr += "C,";
                  break;
                case 3:
                  this.exam_detail[question_index].question.userAnswerStr += "D,";
                  break;
              }
            }
          }
        }
        if (this.exam_detail[question_index].question.userAnswerStr.length != 0) {
          this.exam_detail[question_index].question.userAnswerStr = this.exam_detail[question_index].question
            .userAnswerStr.substr(0, this.exam_detail[question_index].question.userAnswerStr.length - 1);
        }
        if (this.exam_detail[question_index].question.userAnswerStr == this.exam_detail[question_index].question
          .answerStr) {
          this.exam_detail[question_index].question.isRight = true;
        }
      },
      chooseJudge(question_index, option_index) {
        if (this.is_submit) return;
        this.$set(this.user_answer, question_index, option_index);
      },
      submit() {
        if (this.is_submit) {
          this.show_result = !this.show_result;
        } else {
          for (var i = 0; i < this.exam_detail.length; i++) {
            if (this.exam_detail[i].questionType == 0) {
              if (this.exam_detail[i].question.rightAnswer == this.user_answer[i]) {
                this.rate[0].right++;
              }
              this.rate[0].sum++;
            } else if (this.exam_detail[i].questionType == 1) {
              if (this.exam_detail[i].question.isRight) {
                this.rate[1].right++;
              }
              this.rate[1].sum++;
            } else if (this.exam_detail[i].questionType == 2) {
              if (this.exam_detail[i].question.rightAnswer == this.user_answer[i]) {
                this.rate[2].right++;
              }
              this.rate[2].sum++;
            } else if (this.exam_detail[i].questionType == 3) {
              if (this.exam_detail[i].question.txt == this.exam_detail[i].question.rightAnswer) {
                this.rate[3].right++;
              }
              this.rate[3].sum++;
            }
          }
          this.is_submit = true;
          this.show_result = true;
        }
      },
      // 返回
      ClickBack() {
        this.$router.push('/user')
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
        if (this.move.start - end >= 50) {
          if (this.pageNum + 1 < this.exam_detail.length) {
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
      }
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
      height: calc(100vh - 120px);

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
      justify-content: space-between;

      div {
        width: 50%;
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
