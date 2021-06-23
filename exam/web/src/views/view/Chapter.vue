<template>
  <div class="chapter">
    <Header :title="ChapterTitle"></Header>
    <div>
      <ul>
        <li v-for="(item,index) in category" :key="index" @click="GoChapter(item._id)">
          <img src="@/assets/images/Chapter/point.png" alt />
          {{item.name}}
          <!-- <span>{{item.Total}}</span> -->
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import Header from '@/components/Header'

export default {
  name: 'Chapter',
  data () {
    return {
      category: [],
      ChapterTitle: '类型选择'
    }
  },
  created () {
    this.getChapter()
  },
  methods: {
    GoChapter (categoryId) {
      this.$router.push(`/ChoiceQuestion/${categoryId}`)
    },
    async getChapter () {
      const res = await this.$http.get('/category')
      let list = [];
      res.data.map((item,index)=>{
        if(item.pre){
          list.push(item);
        }
      })
      // console.log(list);
      this.category = list;
      // console.log(this.category);
    }
  },
  components: {
    Header
  }

}
</script>

<style lang='less' scoped>
li {
  height: 50px;
  font-size: 5vw;
  line-height: 50px;
  display: block;
  border-bottom: 1px solid #eee;
  margin: 0 30px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  img {
    width: 35px;
    height: 35px;
    margin-right: 15px;
    vertical-align: middle;
  }
}

span {
  float: right;
}
</style>
