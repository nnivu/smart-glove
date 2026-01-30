<template>
  <div class="login-container">
    <div class="login-box">
      <h2 class="login-title">系统登录</h2>
      <form class="login-form" @submit.prevent="handleLogin">
        <div class="form-item">
          <label>账号</label>
          <input
              type="text"
              v-model="loginForm.username"
              placeholder="请输入登录账号"
              class="form-input"
          />
        </div>
        <div class="form-item">
          <label>密码</label>
          <input
              type="password"
              v-model="loginForm.password"
              placeholder="请输入登录密码"
              class="form-input"
          />
        </div>
        <div class="form-item">
          <label>登录角色</label>
          <select v-model="loginForm.role" class="form-select">
            <option value="user">普通用户</option>
            <option value="admin">系统管理员</option>
          </select>
        </div>
        <div class="error-text" v-if="errorMsg">{{ errorMsg }}</div>
        <button type="submit" class="login-btn" :disabled="loading">
          <span v-if="loading">登录中...</span>
          <span v-else>立即登录</span>
        </button>
        <div class="register-link">
          没有账号？<span @click="toRegister">立即注册</span>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
const BASE_URL = 'http://localhost:9090'

export default {
  setup() {
    const router = useRouter()

    // 登录表单数据，默认角色小写user匹配下拉框，和后端一致
    const loginForm = reactive({
      username: '',
      password: '',
      role: 'user'
    })

    const loading = ref(false)
    const errorMsg = ref('')

    const handleLogin = async () => {
      errorMsg.value = ''
      // 基础校验
      if (!loginForm.username.trim()) {
        errorMsg.value = '请输入登录账号'
        return
      }
      if (!loginForm.password.trim()) {
        errorMsg.value = '请输入登录密码'
        return
      }

      loading.value = true
      try {
        const res = await fetch(`${BASE_URL}/login`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json;charset=utf-8'
          },
          body: JSON.stringify({
            username: loginForm.username.trim(),
            password: loginForm.password.trim(),
            role: loginForm.role
          })
        })

        const result = await res.json()
        // 匹配后端字符串类型的200成功码
        if (result.code === "200") {
          // 1. 存储用户信息（原有逻辑保留）
          localStorage.setItem('userInfo', JSON.stringify(result.data))
          // 2. 兼容Token存储：后端返回token就存，没返回不存、不报错（核心适配）
          if (result.data && result.data.token) {
            localStorage.setItem('token', result.data.token)
          }
          alert('登录成功！')
          router.push('/home')
        } else {
          // 适配后端message/msg字段，友好提示
          errorMsg.value = result.message || result.msg || '登录失败，请检查账号密码'
        }
      } catch (err) {
        errorMsg.value = '服务器连接失败，请稍后重试'
        console.error('登录请求异常：', err)
      } finally {
        loading.value = false
      }
    }

    // 跳转到注册页
    const toRegister = () => {
      router.push('/register')
    }

    return {
      loginForm,
      loading,
      errorMsg,
      handleLogin,
      toRegister
    }
  }
}
</script>

<style scoped>
.login-container {
  width: 100vw;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #f5f7fa;
  margin: 0;
  padding: 0;
}
.login-box {
  width: 380px;
  padding: 30px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}
.login-title {
  text-align: center;
  color: #333;
  margin: 0 0 25px 0;
  font-size: 22px;
}
.login-form {
  width: 100%;
}
.form-item {
  margin-bottom: 20px;
}
.form-item label {
  display: block;
  font-size: 14px;
  color: #666;
  margin-bottom: 6px;
}
.form-input, .form-select {
  width: 100%;
  height: 42px;
  padding: 0 12px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  font-size: 14px;
  box-sizing: border-box;
}
.form-input:focus, .form-select:focus {
  outline: none;
  border-color: #409eff;
}
.error-text {
  color: #f56c6c;
  font-size: 13px;
  text-align: center;
  margin-bottom: 15px;
  min-height: 16px;
}
.login-btn {
  width: 100%;
  height: 44px;
  background-color: #409eff;
  color: #fff;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  cursor: pointer;
}
.login-btn:disabled {
  background-color: #c6e2ff;
  cursor: not-allowed;
}
.register-link {
  text-align: center;
  margin-top: 20px;
  font-size: 14px;
  color: #666;
}
.register-link span {
  color: #409eff;
  cursor: pointer;
}
</style>