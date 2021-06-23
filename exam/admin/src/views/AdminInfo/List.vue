<template>
  <div>
    <h1>管理员列表</h1>
    <el-table :data="items">
      <el-table-column prop="_id" label="ID" width="230"></el-table-column>
      <el-table-column prop="username" label="用户名"></el-table-column>
      <el-table-column fixed="right" label="操作" width="180">
        <template slot-scope="scope">
          <el-button
            type="text"
            size="small"
            @click="$router.push(`/admin/adminInfo/edit/${scope.row._id}`)"
          >编辑</el-button>
          <el-button type="text" size="small" @click="remove(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
export default {
  data () {
    return {
      items: []
    }
  },
  created () {
    // 放在这里自动执行
    this.fetch()
  },
  methods: {
    async fetch () {
      let res = await this.$http.get('admininfo')
      console.log(res)
      this.items = res.data
      if((this.currentPage-1)*this.pagesize>=this.items.length){
        this.currentPage--;
      }
      console.log(this.items)
    },
    async remove (row) {
      this.$confirm(`是否删除管理员${row.username}`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async () => {
        // 请求删除的接口
        await this.$http.delete(`adminInfo/${row._id}`).then(res => {
          console.log(res)
          this.$message({
            type: 'success',
            message: '删除成功!'
          })
          this.fetch()
        })
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        })
      })
    }
  }
}
</script>

<style scoped>
</style>
