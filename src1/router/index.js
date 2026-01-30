import { createRouter, createWebHistory } from 'vue-router'
// 引入登录/注册页（路径按你实际位置改）
import Login from '../views/Login.vue'
import Register from '../views/Register.vue'
// 引入系统主面板（Home.vue）
import Home from '../views/Home.vue'

// 定义路由规则
const routes = [
    { path: '/', redirect: '/login' }, // 默认跳登录页
    { path: '/login', component: Login }, // 登录页
    { path: '/register', component: Register }, // 注册页
    { path: '/home', component: Home } // 登录后跳主面板（Home.vue）
]

// 创建路由实例
const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router
