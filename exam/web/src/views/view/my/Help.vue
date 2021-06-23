<template>
  <div>
    <Header title="帮助与反馈"></Header>
    <el-collapse style="width:95%;margin:0 auto">
      <el-collapse-item title="为什么打开我的错题为空？" name="1">
        <div>
          我的错题是针对分类练习以及随机练习进行总结当前用户的错题，需要在当前用户练习作答之后进行多次练习我的错题
        </div>
      </el-collapse-item>
      <el-collapse-item title="错题清空相关问题" name="2">
        <div>错题清空是针对我的错题进行清空操作</div>
      </el-collapse-item>
       <el-collapse-item title="高频错题是以什么维度进行划分？" name="3">
        <div>高频错题是系统给用户设定总结常见的高频易错率的试题，为用户提供常见易错知识点</div>
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