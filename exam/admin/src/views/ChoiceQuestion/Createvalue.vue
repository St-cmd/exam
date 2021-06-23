<template>
  <div class="ChoiceQuestion">
    <h1>录入选择题</h1>
    <el-form label-width="120px" @submit.native.prevent="save">
      <el-form-item label="录入题目">
        <el-input v-model="question.title"></el-input>
      </el-form-item>
      <el-form-item label="录入答案选项">
        <div class="answers">
          <span>A：</span>
          <el-input v-model="question.answerA"></el-input>
        </div>
        <div class="answers">
          <span>B：</span>
          <el-input v-model="question.answerB"></el-input>
        </div>
        <div class="answers">
          <span>C：</span>
          <el-input v-model="question.answerC"></el-input>
        </div>
        <div class="answers">
          <span>D：</span>
          <el-input v-model="question.answerD"></el-input>
        </div>
        <div class="answers">
          <span>正确答案：</span>
          <el-input v-model="question.rightAnswer"></el-input>
        </div>
      </el-form-item>
      <div class="category">
        <el-form-item label="所属分类">
          <el-select v-model="value" placeholder="请选择">
            <el-option v-for="(item, i) in category" :key="item._id" :label="item.name" :value="i"></el-option>
          </el-select>
        </el-form-item>
        <!-- <el-form-item label="前置类型"> -->
        <!-- {{value}} -->
        <!-- <el-input placeholder="请输入内容" :value="!value||category[value].pre == 'undefined' ? '无': category[value].pre.name" :disabled="true">
        </el-input>-->
        <!-- <el-select v-model="preValue" disabled placeholder="1.计算机组成与结构">
            <el-option
              v-for="item in preOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            ></el-option>
        </el-select>-->
        <!-- </el-form-item> -->
      </div>
      <el-form-item>
        <el-button type="primary" native-type="submit">提交保存</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  props: {
    // 这样的好处是尽可能跟路由解耦
    id: {}
  },
  data () {
    return {
      question: {
        category: {
          categoryId: '',
          categoryName: ''
        }
      },
      category: [],
      value: '',
      preCategory: [],
      categoryPre: {}
    }
  },
  watch: {
    'value': function (i) {
      // if (i === 0) return
      // console.log(this.label)
      this.question.category.categoryId = this.category[i]._id
      this.question.category.categoryName = this.category[i].name
    }
  },
  created () {
    // 获取分类
    this.fetchCategory()
    // 获取前置分类
    // this.fetchPreCategory()
  },
  methods: {
    async save () {
      // 将题目保存到数据库
      const res = await this.$http.post('choiceQuestion', this.question)
      console.log(res)
      // 创建完成后跳转到分类列表
      this.$router.push('/admin/choiceQuestion/list').catch(error => {
        console.log(error)
      })
      this.$message({
        type: 'success',
        message: '保存成功'
      })
    },
    // 获取分类数据
    async fetchCategory () {
      const res = await this.$http.get('category')
      console.log(res)
      this.category = res.data
      console.log(this.category)
    }
    // async fetch () {
    //   const res = await this.$http.get(`choiceQuestion/${this.id}`)
    //   this.question = res.data
    // }
  }
}
</script>

<style scoped>
.answers {
  display: flex;
  margin: 20px 0;
}
.answers span {
  flex-basis: 90px;
}
.category {
  display: flex;
}
</style>
