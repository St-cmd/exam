<template>
  <div class="ChoiceQuestion">
    <h1>录入单选题</h1>
    <el-form label-width="120px" @submit.native.prevent="save">
      <el-form-item label="录入题目">
        <el-input v-model="question.title"></el-input>
      </el-form-item>
      <el-form-item label="录入答案选项">
        <el-radio-group v-model="question.rightAnswer">
          <div class="answers">
            <el-radio label="A"><el-input placeholder="请输入选项A内容" v-model="question.answerA"></el-input></el-radio>
          </div>
          <div class="answers">
            <el-radio label="B"><el-input placeholder="请输入选项B内容" v-model="question.answerB"></el-input></el-radio>
          </div>
          <div class="answers">
            <el-radio label="C"><el-input placeholder="请输入选项C内容" v-model="question.answerC"></el-input></el-radio>
          </div>
          <div class="answers">
            <el-radio label="D"><el-input placeholder="请输入选项D内容" v-model="question.answerD"></el-input></el-radio>
          </div>
        </el-radio-group>
      </el-form-item>
      <div class="category">
        <el-form-item label="所属分类">
          <el-select v-model="value" placeholder="请选择">
            <el-option
              v-for="(item, i) in categories"
              :key="item._id"
              :label="item.name"
              :value="i"
            ></el-option>
          </el-select>
        </el-form-item>
      </div>
      <el-form-item label="难度系数">
        <el-rate v-model="question.rate" show-text :texts="texts" style="margin-top:0.7rem"></el-rate>
      </el-form-item>
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
        },
        rate: 0
      },
      categories: [],
      value: '',
      texts: ['一般', '一般', '较难', '特难', '极难']
      // preCategory: []
    }
  },
  watch: {
    'value': function (i) {
      console.log(i)
      this.question.category.categoryId = this.categories[i]._id
      this.question.category.categoryName = this.categories[i].name
    }
  },
  created () {
    // 获取修改数据
    this.id && this.fetch()
    // 获取分类
    this.fetchCategory()
    // 获取前置分类
    // this.fetchPreCategory()
  },
  mounted () {
    // console.log(this.$refs.pre.$el)
    // this.$refs.pre.value = this.categories[this.index].pre === 'undefined' ? '无' : this.categories[this.index].pre.name
  },
  methods: {
    async save () {
      let res
      // console.log(this.question.title==null);
      if (this.question.title == null) {
        this.$message({
          type: "fail",
          message: "题目不可为空",
        });
        return;
      }
      // 将题目保存到数据库
      if (this.id) {
        // 修改题目
        res = await this.$http.put(`/choiceQuestion/${this.id}`, this.question)
      } else {
        // 存入题目
        res = await this.$http.post('/choiceQuestion', this.question)
      }
      console.log(res)
      // 创建完成后跳转到分类列表
      this.$router.push('/admin/choiceQuestion/list')
        .catch(error => { console.log(error) })
      this.$message({
        type: 'success',
        message: '保存成功'
      })
    },
    // 获取修改数据
    async fetch () {
      const res = await this.$http.get(`/choiceQuestion/${this.id}`)
      console.log(res)
      this.question = res.data.question
      console.log(this.question)
    },
    // 获取分类数据
    async fetchCategory () {
      const res = await this.$http.get('category')
      console.log(res)
      this.categories = res.data
      this.categories.forEach((item, index, array) => {
        if (this.question.category.categoryId === item._id) {
          this.value = index
          return false
        }
      })
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
