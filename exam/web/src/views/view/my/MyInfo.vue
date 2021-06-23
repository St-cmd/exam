<template>
  <div>
    <Header title="我的资料"></Header>
    <div class="modelClass" @click="nickDialogShow=true">
      <span>昵称：</span>
      <p class="userinfo">
        <span>{{ username }}</span>
        <span class="symbol">&gt;</span>
      </p>
    </div>
    <el-dialog title="提示" :visible.sync="nickDialogShow" width="70%" :before-close="closeEditNick">
      <el-form label-width="3em">
        <el-form-item label="昵称">
          <el-input type="text" name="username" id="" placeholder="请输入昵称" v-model="changename"></el-input>
        </el-form-item>
        <el-row type="flex" class="row-bg" justify="center">
          <el-col :span="6">
            <el-button style="margin-top: 10px;" @click="edit_nick()">修改</el-button>
          </el-col>
        </el-row>
      </el-form>
    </el-dialog>
    <div class="modelClass" @click="pwdDialogShow=true">
      <span>修改密码：</span>
      <p class="userinfo">
        <span></span>
        <span class="symbol">******&gt;</span>
      </p>
    </div>

    <el-dialog title="提示" :visible.sync="pwdDialogShow" width="70%" :before-close="closePwdDialog">
      <el-form label-width="3em">
        <el-form-item label="密码">
          <el-input type="text" name="username" id="" placeholder="请输入密码" v-model="pwd"></el-input>
        </el-form-item>
        <el-row type="flex" class="row-bg" justify="center">
          <el-col :span="6">
            <el-button style="margin-top: 10px;" @click="edit_pwd()">修改</el-button>
          </el-col>
        </el-row>
      </el-form>
    </el-dialog>
  </div>
</template>
<script>
  import Header from "@/components/Header";
  export default {
    components: {
      Header,
    },
    data() {
      return {
        username: "",
        changename: "",
        dialogShow: false,
        pwdDialogShow: false,
        pwd: "",
        nickDialogShow: false
      };
    },
    mounted() {
      this.username = this.getCookie("username")
    },
    methods: {
      async edit_nick() {
        let res = await this.$http.post("/userinfo/edit_nick", {
          "username": this.username,
          "changename": this.changename
        });
        if (res.status == 200) {
          this.$message({
            showClose: true,
            message: '修改成功',
            type: 'success'
          });
          this.setCookie('username', this.changename, 30)
          this.username = this.getCookie("username")

        } else {
          this.$message({
            showClose: true,
            message: res.data.message,
            type: 'error'
          });
        }
      },
      //设置密码
      async edit_pwd() {
        let res = await this.$http.post("/userinfo/edit_pwd", {
          "username": this.username,
          "pwd": this.pwd
        });
        if (res.status == 200) {
          this.$message({
            showClose: true,
            message: '修改成功',
            type: 'success'
          });
        } else {
          this.$message({
            showClose: true,
            message: res.data.message,
            type: 'error'
          });
        }
      },
      setCookie(name, value, expiredays) {
        var exdate = new Date()
        exdate.setDate(exdate.getDate() + expiredays)
        document.cookie = name + '=' + escape(value) + ''
      },
      // 获取当前用户名
      getCookie(name) {
        var arr = document.cookie.match(
          new RegExp("(^| )" + name + "=([^;]*)(;|$)")
        );
        if (arr != null) {
          return unescape(arr[2]);
        }
        return null;
      },
      closePwdDialog(done) {
        done();
      },
      closeEditNick(done) {
        done();
      }

    },
  };
</script>
<style lang="less" scoped>
  * {
    margin: 0;
    padding: 0;
  }

  .modelClass {
    margin: 0 15px;
    font-size: 18px;
    display: flex;
    justify-content: space-between;
    border-bottom: 1px solid #ddd;
    line-height: 50px;

    .userinfo {
      color: #666;

      .symbol {
        display: inline-block;
        margin-left: 10px;
      }
    }
  }

  .showdialog {
    width: 100%;
    height: 100%;
    position: fixed;
    top: 0;
    left: 0;
    background: rgba(0, 0, 0, 0.3);

    .dialog {
      border-radius: 15px;
      width: 70%;
      height: 50%;
      position: absolute;
      top: 0;
      right: 0;
      bottom: 0;
      left: 0;
      margin: auto;
      background-color: white;

      .cancel {
        float: right;
        margin: 0 15px 0 0;
        font-size: 30px;
      }

      .inputClass {
        margin: 40px 0 0 0;
        text-align: center;
      }
    }
  }
</style>
