<!-- src/App.vue 正确代码（极简，只做路由容器） -->
<template>
  <router-view></router-view>
</template>

<script setup>
// 这里什么都不用写，路由会自动渲染匹配的页面
</script>

<style>
/* 可以加全局样式，比如页面默认的margin/padding重置 */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}
</style>