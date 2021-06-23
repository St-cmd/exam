<template>
  <div class="print">
    <Header title="刷题"></Header>
    <div class="container" :style="{width:screenWidth * 5 + 'px'}">
      <div
        class="box"
        v-for="(item,index) in question"
        :key="index"
        :style="{width:screenWidth + 'px'}"
      >
        <div class="title">{{item.title}}</div>
        <!-- 选项 -->
        <div class="choice">
          <div class="option" v-for="(choice,i) in list" :key="i" @click="action(i,index)">
            <!-- abcd -->
            <div
              class="answer"
              :style="{background: i === item.answer && actionData[index] === i  ? 'green' : ''}"
            >{{answer[i]}}</div>
            (item.answer:{{item.answer}}) - (i:{{i}}) - (actionData:{{actionData[index]}})
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Header from '../../components/Header'

export default {
  data () {
    return {
      actionData: [], // 储存选中选项
      question: [],
      list: ['程序计数器 (PC)', '累加器 (AC)', '指令寄存器 (IR)', '地址寄存器 (AR)'],
      answer: ['A', 'B', 'C', 'D'],
      screenWidth: document.documentElement.clientWidth
    }
  },
  created () {
    this.getQuestion()
  },
  components: {
    Header
  },
  methods: {
    // touchStart(){
    //   if()
    // }
    // 获取题目
    async getQuestion () {
      const res = await this.$http.get('/choiceQuestion')
      console.log(res)
      // 整理答案数组
      for (let i = 0; i < res.data.length; i++) {
        let result = res.data[i].question
        let title = result.title // 题目
        let answerList = [result.answerA, result.answerB, result.answerC, result.answerD] // 答案数组
        let rate = result.rate // 难度
        let right = result.rightAnswer // 正确答案
        // 将ABCD选项转化为数字
        switch (right) {
          case 'A':
            right = 0
            break
          case 'B':
            right = 1
            break
          case 'C':
            right = 2
            break
          case 'D':
            right = 3
            break
        }
        let category = result.category // 分类
        let question = { title, answerList, rate, right, category }
        console.log(question)
        this.question.push(question)
      }
      console.log(this.question)
    },
    action (i, index) {
      this.$set(this.actionData, index, i)
      // console.log(i, index) // index -第几道题 i-循环第几个选项
      // 记录正确答案
      let right = this.question[index].right
      this.question[index].answer = right
      console.log(right, i)
    }
  }
}
</script>

<style scoped>
.container {
  position: absolute;
  height: 100vh;
}
.box {
  float: left;
  box-sizing: border-box;
}
.option {
  display: flex;
  margin: 20px 10px;
  align-items: center;
}
.answer {
  width: 30px;
  height: 30px;
  border-radius: 50%;
  background: #eee;
  margin-right: 10px;
  text-align: center;
  vertical-align: middle;
}
</style>
