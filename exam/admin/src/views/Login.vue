<template>
  <div class="bg">
    <div class="login-container">
      <el-card header="请先登录" class="login-card">
        <el-form @submit.native.prevent="login">
          <el-form-item label="用户名">
            <el-input v-model="model.username"></el-input>
          </el-form-item>
          <el-form-item label="密码">
            <el-input type="password" v-model="model.password"></el-input>
          </el-form-item>
          <el-alert
            class="error-message"
            title="用户名或者密码错误"
            type="error"
            v-if="showErrorMsg"
            effect="dark"
          >
          </el-alert>
          <el-form-item>
            <el-button type="primary" native-type="submit">登录</el-button>
          </el-form-item>
        </el-form>
      </el-card>
    </div>
  </div>
</template>

<script>
export default {
  props: {},
  data() {
    return {
      model: {},
      showErrorMsg: false,
    };
  },
  created() {},
  methods: {
    async login() {
      console.log(this.model);
      const res = await this.$http.post("login/match", this.model);
      console.log(res);
      // this.$router.push('/admin')
      if (res.data === 200) {
        console.log(this.model.username);
        this.setCookie("adminusername", "", -1);
        var dataCookie = this.model.username;
        document.cookie = "adminusername" + "=" + dataCookie;
        this.$router.push("/admin");
      } else {
        // this.$notify.error({
        //   title: '错误',
        //   message: '用户名或者密码错误',
        //   duration: 3000
        // })
        this.showErrorMsg = true;
        this.errorMessage = "用户名或者密码错误";
      }
    },
    setCookie(name, value, expiredays) {
      console.log("set cookie " + name + ",value " + value);
      var exdate = new Date();
      exdate.setDate(exdate.getDate() + expiredays);
      document.cookie = name + "=" + escape(value) + "";
    },
  },
};
</script>

<style scoped>
.login-card {
  width: 25rem;
  margin: 5rem auto;
}
.error-message {
  margin-bottom: 20px;
}
/* .bg{
  background: url(../assets/bg.jpg) no-repeat;
  background-size: 550px;
} */
</style>
