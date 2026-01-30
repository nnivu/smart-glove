// src/main.js 完整正确代码（一字不差复制）
import { createApp } from 'vue'
import App from './App.vue'

// 1. 引入路由实例（路径必须正确，指向你的router/index.js）
import router from './router/index.js'

// 2. 创建App实例
const app = createApp(App)

// 3. 挂载路由（关键！这行注册了router-view组件）
app.use(router)

// 4. 挂载到#app
app.mount('#app')