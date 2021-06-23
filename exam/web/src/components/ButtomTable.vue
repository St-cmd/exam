<template>
  <div class="ButtomTable">
    <div
      v-for="item in listData"
      :class="['list',{'action': item.url == url}]"
      :key="item.title"
      @click="goBack(item.url)"
    >
      <img :src="item.url == url ? item.action : item.img" />
      {{ item.title }}
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      listData: [
        { title: '练习', url: '/user', action: require('../assets/images/ButtomTable/ExerciseAction.png'), img: require('../assets/images/ButtomTable/Exercise.png') },
        { title: '我', url: '/user/Me', action: require('../assets/images/ButtomTable/MeAction.png'), img: require('../assets/images/ButtomTable/Me.png') }
      ],
      url: ''
    }
  },
  mounted () {
    this.url = this.$route.path
  },
  methods: {
    goBack (url) {
      this.url = url
      this.$router.push(url)
    }
  }
}
</script>

<style scoped lang='less'>
.ButtomTable {
  display: flex;
  background-color: #f7f7f7;
  border-top: 1px solid #b9b9b9;
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100vw;
  .list {
    width:50%;
    height:49px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    background-color: #f7f7f7;
    padding: 15px 0 5px 0;
    img {
      width:25px;
      height:25px;
    }
  }
  .action {
    color: #0fbcf9;
  }
}
</style>
