<template>
  <div class="CategoryList">
    <h3>分类列表</h3>
    <el-table :data="items.slice((currentPage - 1) * pagesize, currentPage * pagesize)">
      <el-table-column prop="_id" label="ID"></el-table-column>
      <el-table-column prop="pre.name" label="前置知识点"></el-table-column>
      <el-table-column prop="name" label="所属分类"></el-table-column>
      <el-table-column fixed="right" label="操作" width="180">
        <template slot-scope="scope">
          <el-button type="text" size="small" @click="edit(scope.row)">编辑</el-button>
          <el-button type="text" size="small" @click="remove(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <div class="pagination" style="display:flex;justify-content:center;">
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        background
        :total="items.length"
        :current-page="currentPage"
        :page-size="pagesize"
        layout="prev, pager, next"
      ></el-pagination>
    </div>
  </div>
</template>

<script>
export default {
  data () {
    return {
      items: [],
      currentPage: 1,
      pagesize: 5 // 每页数量
    }
  },
  created () {
    this.fetch()
  },
  methods: {
    // 获取题目数据
    async fetch () {
      const res = await this.$http.get('category')
      console.log(res.data)
      this.items = res.data
      if((this.currentPage-1)*this.pagesize>=this.items.length){
        this.currentPage--;
      }
    },
    // 编辑
    edit (row) {
      console.log(row)
      let type = 'pre';
      if (!row.pre) {
        type = 'later'
      }
      this.$router.push({path:`/admin/category/edit/${row._id}`,query:{flag:false,type: type}})
    },
    // 删除
    async remove (row) {
      this.$confirm(`是否删除分类${row.name}`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async () => {
        // 请求删除的接口
        await this.$http.delete(`category/${row._id}`)
        this.$message({
          type: 'success',
          message: '删除成功!'
        })
        this.fetch()
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        })
      })
    },
    // 分页
    handleSizeChange: function (val) {
      this.pagesize = val
    },
    handleCurrentChange: function (currentPage) {
      this.currentPage = currentPage
    }
  }
}
</script>

<style>
</style>
