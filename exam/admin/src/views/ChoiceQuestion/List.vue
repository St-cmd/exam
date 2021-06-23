<template>
  <div class="choiceQuestion">
    <h1>单选题列表</h1>
    <!-- {{ items.length }} -->
    <el-table :data="items.slice((currentPage - 1) * pagesize, currentPage * pagesize)">
      <el-table-column prop="_id" label="ID" width="240"></el-table-column>
      <el-table-column prop="question.title" label="题目"></el-table-column>
      <el-table-column prop="question.category.categoryName" label="所属分类"></el-table-column>
      <el-table-column fixed="right" label="操作" width="180">
        <template slot-scope="scope">
          <el-button
            type="text"
            size="small"
            @click="$router.push(`/admin/choiceQuestion/edit/${scope.row._id}`)"
          >编辑</el-button>
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
      question: {},
      currentPage: 1,
      pagesize: 5 // 每页数量
    }
  },
  created () {
    this.fetch()
  },
  methods: {
    async fetch () {
      // 查找题目
      const res = await this.$http.get('/choiceQuestion')
      console.log(res)
      this.items = res.data
      if((this.currentPage-1)*this.pagesize>=this.items.length){
        this.currentPage--;
      }
      //   console.log(this.items.)
    },
    async remove (row) {
      this.$confirm(`是否删除题目`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async () => {
        // 请求删除的接口
        const res = await this.$http.delete(`choiceQuestion/${row._id}`)
        console.log(res)
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
