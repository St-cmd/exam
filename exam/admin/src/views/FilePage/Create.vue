<template>
  <div class="FileCreate">
    <h1>上传文件</h1>
    <el-form label-width="120px" @submit.native.prevent="save">

      <el-form-item label="选择题目类型">
        <el-select v-model="optionValue" placeholder="请选择">
          <el-option v-for="item in options" :key="item.id" :label="item.title" :value="item.id">
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item class="answers" label="上传">
        <el-upload class="upload-demo" :action="$http.defaults.baseURL + '/file/upload'" :limit="1"
          :file-list="fileList" :on-success="afterUpload">
          <el-button size="small" type="primary">点击上传</el-button>
        </el-upload>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" native-type="submit">提交保存</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
  export default {
    props: {},
    data() {
      return {
        options: [{
            "id": 0,
            "title": "单选题"
          },
          {
            "id": 1,
            "title": "多选题"
          },
          {
            "id": 2,
            "title": "判断题"
          },
          {
            "id": 3,
            "title": "论述题"
          },
        ],
        optionValue: 0,
        fileList: [],
        model: {},
        filename: ""
      }
    },
    methods: {
      async save() {
         this.$http.get('/file/analyze', {
          params: {
            "questionType": this.optionValue,
            "filename": this.filename
          }
        }).then(res => {
          // 创建完成后跳转到分类列表
          // this.$router.push('/admin/filePage/list')
          //   .catch(error => { console.log(error) })
          this.$message({
            message: '上传成功！',
            type: 'success'
          });
        }).catch(rej=>{
          this.$message({
            message: '上传失败！',
            type: 'fail'
          });
        })
        
      },
      // 上传文件成功后的回调函数
      afterUpload(res) {
        this.filename = res.filename;
      }
    }
  }
</script>

<style>
  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }

  .avatar-uploader .el-upload:hover {
    border-color: #409eff;
  }

  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 178px;
    height: 178px;
    line-height: 178px;
    text-align: center;
  }

  .avatar {
    width: 178px;
    height: 178px;
    display: block;
  }
</style>
