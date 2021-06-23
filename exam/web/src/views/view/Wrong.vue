<template>
  <div class="wrong">
    <Header :title="wrongtitle"></Header>
    <!-- 易错率较高 -->
    <div class="item clear" @click="clickItem(item.id)" v-for="item in list" :key="item.id">
      <div class="left">
        <img :src="item.img" alt />
      </div>
      <div class="content">
        <div class="title">
          <h3>{{item.title}}</h3>
          <img src="@/assets/images/Wrong/pen.png" alt />
        </div>
        <div class="bar"></div>

      </div>
    </div>
  </div>
</template>

<script>
import Header from '@/components/Header'
export default {
  data () {
    return {
      wrongtitle: '高频错题',
      frqObj: null,
      unqieTitleArr: [],
      list: [
        { id: 1, title: '易错率较高', img: require('@/assets/images/Wrong/normal.png') },
        { id: 2, title: '易错率特高', img: require('@/assets/images/Wrong/middle.png') },
        { id: 3, title: '易错率极高', img: require('@/assets/images/Wrong/high.png') }
      ]
    }
  },
  created () {
    // this.getWrongQuestion()
  },
  methods: {
    clickItem (id) {
      console.log(id)
      this.$router.push(`/ChoiceQuestion/${id}`)
    }
  },
  components: {
    Header
  }
}
</script>

<style scope lang="less">
.item {
  height: 130px;
  box-shadow: 0 0 8px rgba(100, 100, 100, 0.8);
  position: relative;
  border-radius: 10px;
  margin: 30px;
  padding: 5px;
  display: flex;
  align-items: center;
  .left {
    padding: 0 10px 0 0;
    img {
      width: 100px;
      height: 6.9231rem;
    }
  }
  .content {
    height: 70%;
    flex: 1;
    .title,
    .rate {
      height: 50%;
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
    .bar {
      width: 100%;
      height: 15px;
      background: rgb(221, 221, 221);
      border-radius: 200px;
      margin-top: 10px;
    }
  }
}
.clear::after {
  content: "";
  display: block;
  clear: both;
}
</style>
