<template>
  <div class="CategoryCreate">
    <h3>{{ id ? "修改" : "新建" }}分类</h3>
    <el-form label-width="120px" @submit.native.prevent="save">
      <el-form-item label="前置分类" v-if="form.type == 'preType'">
        <el-select v-model="model.pre">
          <el-option
            v-for="item in preCategories"
            :key="item._id"
            :label="item.name"
            :value="item._id"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="分类名称">
        <el-input v-model="model.name"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" native-type="submit">提交保存</el-button>
      </el-form-item>
    </el-form>
    <!-- 选择前置分类还是分类弹框 -->
    <el-dialog title="选择类型" :visible.sync="dialogFormVisible">
      <el-form ref="form" :model="form" label-width="80px">
        <el-form-item label="设置分类">
          <el-select v-model="form.type" placeholder="请选择分类类型">
            <el-option label="分类" value="preType"></el-option>
            <el-option label="前置分类" value="type"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="dialogFormVisible = false"
          >确 定</el-button
        >
      </div>
    </el-dialog>
  </div>
</template>

<script>
export default {
  props: {
    id: {},
  },
  data() {
    return {
      model: {}, // 保存分类
      form: {
        type: "",
      }, //选择前置分类/分类表单
      preCategories: [], // 上级分类的数组数据
      dialogFormVisible: true,
      formLabelWidth: "120px",
    };
  },
  created() {
    this.id && this.fetch();
    this.fetchPreOptios();
    console.log(this.$route);
    if (this.$route.query.flag) {
      this.dialogFormVisible = false;
      console.log(this.dialogFormVisible);
    }
    if (this.$route.query.type == 'pre') {
      this.form.type = 'preType'
    }else{
      this.form.type = 'type'
    }
  },
  methods: {
    async save() {
      let res;
      // console.log(this.model)
      // console.log(this.model.name==null);
      if (this.model.name == null) {
        this.$message({
          type: "fail",
          message: "分类名称不可为空",
        });
        return;
      }
      if (this.id) {
        res = await this.$http.put(`/category/${this.id}`, this.model);
      } else {
        res = await this.$http.post("category", this.model);
      }
      this.$router.push("/admin/category/list");
      this.$message({
        type: "success",
        message: "保存成功",
      });
    },
    async fetch() {
      const res = await this.$http.get(`/category/${this.id}`);
      console.log(res);
      this.model = res.data;
    },
    async fetchPreOptios() {
      const res = await this.$http.get(`/category`);
      console.log(res.data)
      let list = [];
      res.data.map((item,index)=>{
        if(!item.pre){
          list.push(item)
        }
      })
      console.log(list);
      this.preCategories = list;
    },
  },
};
</script>

<style>
</style>
