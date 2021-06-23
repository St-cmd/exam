<template>
  <div class="Header">
    <div class="left">
      <slot name="left">
        <img src="@/assets/images/Header/back.png" alt @click="ClickBack" />
      </slot>
    </div>
    <div class="center">
      <h2>{{title}}</h2>
    </div>
    <div class="right">
      <slot name="right"></slot>
    </div>
    <!-- <img src="@/assets/images/Header/back.png" alt @click="ClickBack" /> -->
  </div>
</template>

<script>
export default {
  props: ["title"],
  methods: {
    ClickBack() {
      this.$router.back(-1);
    },
  },
};
</script>

<style lang="less" scoped>
.Header {
  border-bottom: 1px solid #b9b9b9;
  display: flex;
  justify-content: center;
  height: 60px;
  line-height: 60px;
  text-align: center;
  align-items: center;
  .center {
    flex: 1;
  }
  h2 {
    margin: 0;
  }
  img {
    width: 25px;
    height: 25px;
  }
}
</style>
