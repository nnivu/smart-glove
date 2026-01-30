<template>
  <div class="login-container">
    <div class="login-box">
      <h2 class="login-title">用户注册</h2>
      <form class="login-form" @submit.prevent="handleRegister">
        <div class="form-item">
          <label>注册账号</label>
          <input
              type="text"
              v-model="registerForm.username"
              placeholder="请输入注册账号（唯一）"
              class="form-input"
          />
        </div>
        <div class="form-item">
          <label>登录密码</label>
          <input
              type="password"
              v-model="registerForm.password"
              placeholder="请输入登录密码"
              class="form-input"
          />
        </div>
        <div class="form-item">
          <label>昵称（选填）</label>
          <input
              type="text"
              v-model="registerForm.nickname"
              placeholder="请输入昵称（选填）"
              class="form-input"
          />
        </div>
        <div class="error-text" v-if="errorMsg">{{ errorMsg }}</div>
        <button type="submit" class="login-btn" :disabled="loading">
          <span v-if="loading">注册中...</span>
          <span v-else>立即注册</span>
        </button>
        <div class="register-link">
          已有账号？<span @click="toLogin">立即登录</span>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
const BASE_URL = 'http://localhost:9090'

// 创建独立的axios实例（无全局拦截器）
const axiosInstance = axios.create({
  baseURL: BASE_URL,
  headers: {
    'Content-Type': 'application/json;charset=utf-8'
  },
  timeout: 10000
})

export default {
  setup() {
    const router = useRouter()

    const registerForm = reactive({
      username: '',
      password: '',
      nickname: ''
    })
    const loading = ref(false)
    const errorMsg = ref('')

    const handleRegister = async () => {
      errorMsg.value = ''
      // 1. 验证输入
      if (!registerForm.username.trim()) {
        errorMsg.value = '请输入注册账号'
        return
      }
      if (!registerForm.password.trim()) {
        errorMsg.value = '请输入登录密码'
        return
      }

      loading.value = true
      try {
        // 2. 核心：缓存原始密码，避免被其他逻辑加密
        const rawPassword = registerForm.password.trim()
        // 3. 构造纯原始数据的请求体（仅包含原始明文密码）
        const submitData = {
          username: registerForm.username.trim(),
          password: rawPassword, // 强制传递原始明文密码
          nickname: registerForm.nickname.trim() || registerForm.username.trim()
        }

        // 4. 使用独立实例发送请求，确保数据不被篡改
        const result = await axiosInstance.post('/register', submitData)
        const resData = result.data

        if (resData.code === "200") {
          alert('注册成功！即将跳转登录页')
          // 清空表单
          registerForm.username = ''
          registerForm.password = ''
          registerForm.nickname = ''
          router.push('/login')
        } else {
          errorMsg.value = resData.message || resData.msg || '注册失败'
        }
      } catch (err) {
        if (err.code === 'ECONNABORTED') {
          errorMsg.value = '请求超时，请检查网络'
        } else if (err.response) {
          errorMsg.value = err.response.data?.message || '注册失败，请稍后重试'
        } else {
          errorMsg.value = '服务器连接失败，请稍后重试'
        }
        console.error('注册请求异常：', err)
      } finally {
        loading.value = false
      }
    }

    const toLogin = () => {
      router.push('/login')
    }

    return {
      registerForm,
      loading,
      errorMsg,
      handleRegister,
      toLogin
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
.form-input {
  width: 100%;
  height: 42px;
  padding: 0 12px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  font-size: 14px;
}
.form-input:focus {
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