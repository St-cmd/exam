<template>
  <div>
    <h1>{{this.id ? '编辑':'新增'}}管理员</h1>
    <el-form label-width="120px" @submit.native.prevent="save">
      <el-form-item label="用户名">
        <el-input v-model="model.username"></el-input>
      </el-form-item>
      <el-form-item label="密码">
        <el-input type="text" v-model="model.password"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" native-type="submit">保存</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  props: {
    id: {}
  },
  data () {
    return {
      model: {}
    }
  },
  created () {
    // 自动执行方法获取 编辑分类的数据
    // 如果id存在，才执行fetch()方法
    this.id && this.fetch()
  },
  methods: {
    async save () {
      console.log('save')
      let res
      if (this.id) { // id存在则put修改
        res = await this.$http.put(`admininfo/${this.id}`, this.model)
        this.model.id = this.id
      } else { // 没有id则新增
        res = await this.$http.post('admininfo', this.model)
      }
      console.log(this.model)
      console.log(res)
      this.$router.push('/admin/adminInfo/list')
      this.$message({
        type: 'success',
        message: '保存成功'
      })
    },
    // id存在时获取数据进行编辑
    async fetch () {
      this.model.id = this.id
      let res = await this.$http.get(`admininfo/${this.id}`)
      console.log(res)
      this.model = res.data
    }
  }
}
</script>

<style scoped>
</style>
