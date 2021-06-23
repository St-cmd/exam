<template>
  <div class="Index">
    <router-view></router-view>
    <ButtomTable />
  </div>
</template>

<script>
import ButtomTable from '@/components/ButtomTable'

export default {
  components: {
    ButtomTable
  }
}
</script>

<style scoped>
/* .Index{
  height:100vh;
} */
/* // @import "../assets/styles/mixin.less";
// .Index {
//   height: 100vh;
//   flex-direction: column;
//   .fj;
//   // padding-bottom: 300px;
// } */
</style>
