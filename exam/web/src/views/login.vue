<template>
  <div class="Login">
    <img src="../assets/images/login/registered.png" alt class="img" />
    <div class="info">
      <input type="text" placeholder="请输入用户名" id="username" v-model="model.username" />
      <br />
      <div class="code">
        <input
          type="password"
          placeholder="请输入密码"
          id="password"
          ref="password"
          v-model="model.password"
        />
      </div>
    </div>
    <el-alert id="error-box"
          title="用户名或者密码错误"
          type="error"
          v-if = "showErrorMsg"
          effect="dark">
        </el-alert>
    <button class="btn btn-com" @click="login">登录</button>
    <div>
    <button class="btn btn-com" @click="register">注册</button>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      isShow: true,
      model: {},
      showErrorMsg: false
    }
  },
  methods: {
    // 登录
    login () {
      this.$http.post('userinfo/match', this.model).then((res) => {
        if (res.data === 200) {
          console.log('登录成功' + this.model.username)
          this.setCookie('username', this.model.username, 30)
          this.$router.push('/user')
        } else {
          this.showErrorMsg = true
          console.log('用户名或密码错误')
        }
      })
    },
    // 注册
    register () {
      this.$router.push('/register')
    },
    // 设置cookie
    setCookie (name, value, expiredays) {
      console.log('set cookie ' + name + ',value ' + value)
      var exdate = new Date()
      exdate.setDate(exdate.getDate() + expiredays)
      document.cookie = name + '=' + escape(value) + ''
    }
  }
}
</script>

<style>
.Login {
  background: #eee;
  width: 100%;
  height: 100vh;
  position: relative;
}
.layer {
  position: absolute;
  top: 40%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: #f55b47;
  opacity: 0.8;
  text-align: center;
  width: 85px;
  border-radius: 10px;
  color: #fff;
  padding: 6px;
}
.img {
  margin: 0 auto;
  padding-top: 100px;
  width: 60px;
  height: 60px;
  display: block;
}
.info {
  margin: 0 auto;
  width: 300px;
  text-align: center;
  margin-top: 50px;
}
.code {
  position: relative;
}
.info input {
  margin-bottom: 10px;
  width: 300px;
  height: 35px;
  border: none;
  border-radius: 5px;
  outline: none;
  padding-left: 5px;
  box-sizing: border-box;
}
.btn-com {
  display: block;
  background: #f55b47;
  color: #fff;
  border: none;
  border-radius: 5px;
  outline: none;
}
.certification {
  width: 85px;
  height: 30px;
  position: absolute;
  right: 7px;
  bottom: 13px;
}
.btn {
  width: 300px;
  height: 35px;
  margin: 0 auto;
  margin-top: 15px;
}
#error-box {
  height: 35px;
  width: 300px;
  margin-top: 15px;
  margin: 0 auto;
}
</style>
