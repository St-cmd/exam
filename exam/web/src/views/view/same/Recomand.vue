<template>
  <div class="Recomand">
    <Header :title="RecomandTitle"></Header>
    <div
      class="item clear"
      @click="RecomandQuestion(index)"
      v-for="(item,index) in category"
      :key="index"
    >
      <div class="content">
        <div class="title">
          <h3>{{item.name}}</h3>
          <img src="@/assets/images/Wrong/pen.png" alt />
        </div>
        <!-- <div class="rate">
          <p>
            已做:
            <span>0</span>
          </p>|
          <p>
            总数:
            <span>150</span>
          </p>|
          <p>正确率0%</p>
        </div> -->
      </div>
    </div>
  </div>
</template>

<script>
import Header from '@/components/Header'
// import
export default {
  data () {
    return {
      RecomandTitle: '同类推荐',
      category: []
      // questionArr: [] // 最终的题目数组
    }
  },
  created () {
    this.getChapter()
  },
  methods: {
    async RecomandQuestion (index) {
      // 传过去获取数据
      this.$router.push(`/ChoiceQuestion/${this.category[index]._id}`)
    },
    async getChapter () {
      const res = await this.$http.get('/category')
      console.log(res)
      this.category = res.data
      console.log(this.category)
    },
    // 根据分类id获取题目
    // 将分类id传到后端，到题库中获取
    async getQuestion (index) {

    }
  },
  components: {
    Header
  }
}
</script>

<style scoped lang="less">
.item {
  box-shadow: 0 0 8px rgba(100, 100, 100, 0.8);
  position: relative;
  border-radius: 10px;
  padding: 10px;
  display: flex;
  align-items: center;
  .content {
    flex: 1;
    .title{
      // height: 30%;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }
    .title {
      img {
        width: 35px;
        height: 35px;
      }
    }
  }
}
.clear::after {
  content: "";
  display: block;
  clear: both;
}
</style>
