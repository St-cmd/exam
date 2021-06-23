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
      <div class="code">
        <input
          type="password"
          placeholder="请确认密码"
          id="password"
          ref="password"
          v-model="confirm"
        />
      </div>
      <div>
        
      </div>
    </div>
    <button class="btn btn-com" @click="register">注册</button>
    <!-- 弹出层 -->
    <!-- <div v-show="isShow" class="layer">
      <p>发送成功</p>
    </div>-->
  </div>
</template>

<script>
export default {
  data () {
    return {
      isShow: true,
      model: {},
      confirm: ''
    }
  },
  methods: {
    // 注册
    register () {
      console.log('call resigter function')
      if (this.model.password === this.confirm) {
        this.$http.post('userinfo/', this.model).then((res) => {
          console.log(res)
          if (res.data === 200) {
            this.$router.push('/login')
          } else {
            alert('用户已存在')
          }
        })
      } else {
        alert('密码不一致')
      }
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
</style>
