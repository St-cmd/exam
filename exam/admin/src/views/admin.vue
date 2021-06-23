<template>
  <div>
    <el-container style="height: 100vh;">
      <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
        <el-menu router :default-openeds="['1']" :default-active="$route.path">
          <el-submenu index="1">
            <template slot="title">
              <i class="el-icon-tickets"></i>题目分类
            </template>
            <el-menu-item-group>
              <template slot="title">分类</template>
              <el-menu-item index="/admin/category/create">新建分类</el-menu-item>
              <el-menu-item index="/admin/category/list">分类列表</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="2">
            <template slot="title">
              <i class="el-icon-message"></i>題目管理
            </template>
            <el-menu-item-group>
              <template slot="title">选择题</template>
              <el-menu-item index="/admin/choiceQuestion/create">单选题录入</el-menu-item>
              <el-menu-item index="/admin/choiceQuestion/list">单选题列表</el-menu-item>
              <el-menu-item index="/admin/multipleChoiceQuestion/create">多选题录入</el-menu-item>
              <el-menu-item index="/admin/multipleChoiceQuestion/list">多选题列表</el-menu-item>
            </el-menu-item-group>
            <el-menu-item-group>
              <template slot="title">判断题</template>
              <el-menu-item index="/admin/judgedQuestion/create">判断题录入</el-menu-item>
              <el-menu-item index="/admin/judgedQuestion/list">判断题列表</el-menu-item>
            </el-menu-item-group>
            <el-menu-item-group>
              <template slot="title">论述题</template>
              <el-menu-item index="/admin/discussQuestion/create">论述题录入</el-menu-item>
              <el-menu-item index="/admin/discussQuestion/list">论述题列表</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="3">
            <template slot="title">
              <i class="el-icon-setting"></i>文件管理
            </template>
            <el-menu-item-group>
              <template slot="title">文件管理</template>
              <el-menu-item index="/admin/filePage/create">上传文件</el-menu-item>
              <!-- <el-menu-item index="/admin/filePage/list">查看文件</el-menu-item> -->
            </el-menu-item-group>
          </el-submenu>
          <el-submenu index="4">
            <template slot="title">
              <i class="el-icon-menu"></i>管理员列表
            </template>
            <el-menu-item-group>
              <template slot="title">管理员信息</template>
              <el-menu-item index="/admin/adminInfo/create">新建管理员</el-menu-item>
              <el-menu-item index="/admin/adminInfo/list">管理员列表</el-menu-item>
            </el-menu-item-group>
          </el-submenu>
        </el-menu>
      </el-aside>

      <el-container>
        <el-header style="text-align: right; font-size: 16px; font-weight: bold">
          <el-dropdown size="medium" @command="handleCommand">
            <div style="font-size: 20px">
            <i class="el-icon-setting" size="medium" style="margin-right: 15px"></i>
            </div>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item command="list">查看</el-dropdown-item>
              <el-dropdown-item command="create">新增</el-dropdown-item>
              <el-dropdown-item command="logout">退出</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
          <span>{{username}}</span>
        </el-header>

        <el-main>
          <router-view></router-view>
          <!-- <el-table :data="tableData">
            <el-table-column prop="date" label="日期" width="140"></el-table-column>
            <el-table-column prop="name" label="姓名" width="120"></el-table-column>
            <el-table-column prop="address" label="地址"></el-table-column>
          </el-table>-->
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script>
export default {
  data () {
    return {
      username: ''
    }
  },
  created: function () { // 生命周期钩子函数，在创建完成之后读取cookie保存的username
    this.username = this.getCookie('adminusername')
  },
  methods: {
    getCookie (name) {
      var arr = document.cookie.match(
        new RegExp('(^| )' + name + '=([^;]*)(;|$)')
      )
      if (arr != null) {
        return unescape(arr[2])
      }
      return null
    },
    handleCommand (command) {
      if (command === 'logout') {
        console.log('user logout')
        this.$router.replace('/')
      } else if (command === 'list') {
        console.log('list')
        this.$router.push('/admin/adminInfo/list')
      } else if (command === 'create') {
        console.log('create')
        this.$router.push('/admin/adminInfo/create')
      }
    }
  }
}
</script>

<style>
.el-header {
  background-color: #b3c0d1;
  color: #333;
  line-height: 60px;
}

.el-aside {
  color: #333;
}
</style>
