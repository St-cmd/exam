<template>
  <div>
    <Header title="关于备考"></Header>
    <img src="../../../assets/images/login/registered.png" alt class="img" />
    <el-collapse style="width:95%;margin:15px auto">
      <el-collapse-item title="检查新版本" name="1">
        <div>
          当前版本为1.0.0
        </div>
      </el-collapse-item>
      <el-collapse-item title="新功能介绍" name="2">
        <div>
          本系统供计算机专业的大学生备考使用，用户可通过各个模块针对性的进行练习
        </div>
      </el-collapse-item>
      <el-collapse-item title="使用规则" name="3">
        <div>
          1.用户可根据指定不同错题频率的题目进行练习高频错题
        </div>
        <div>
          2.用户可通过分类练习以及随机练习生成的错题进行我的错题练习
        </div>
        <div>
          3.用户可通过我的试卷对题目进行试卷模拟
        </div>
       
      </el-collapse-item>
    </el-collapse>
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
    
    };
  },
  methods: {
   
  },
};
</script>
<style lang="less" scoped>

</style>