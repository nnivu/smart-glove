<template>
  <div class="home-container">
    <!-- 顶部栏 -->
    <header class="top-bar">
      <h1>AI焊接培训系统</h1>
      <div class="top-right">
        <span>AI驱动的智能培训平台</span>
        <span class="status-dot"></span>
      </div>
    </header>

    <!-- 主体区域：左侧模块栏 + 右侧内容区 -->
    <div class="main-content">
      <!-- 左侧系统模块栏 -->
      <aside class="sidebar">
        <h2>系统模块</h2>
        <div
            class="module-item"
            :class="{ active: activeModule === 'qa' }"
            @click="activeModule = 'qa'"
        >
          <i class="icon-qa"></i>
          <span>AI智能问答</span>
          <p>焊接知识学习与问答</p>
        </div>
        <div
            class="module-item"
            :class="{ active: activeModule === 'feedback' }"
            @click="activeModule = 'feedback'"
        >
          <i class="icon-feedback"></i>
          <span>错误收集反馈</span>
          <p>实时错误监控与分析</p>
        </div>
        <div
            class="module-item"
            :class="{ active: activeModule === 'training' }"
            @click="activeModule = 'training'"
        >
          <i class="icon-training"></i>
          <span>姿态训练模拟</span>
          <p>智能姿态分析与指导</p>
        </div>
        <div
            class="module-item"
            :class="{ active: activeModule === 'suggestion' }"
            @click="activeModule = 'suggestion'"
        >
          <i class="icon-suggestion"></i>
          <span>问题总结建议</span>
          <p>行业对比与改进建议</p>
        </div>
      </aside>

      <!-- 右侧内容区 -->
      <main class="content-area">
        <component :is="currentComponent" />
      </main>
    </div>
  </div>
</template>

<script>
import QAModule from '../components/QAModule.vue'
import FeedbackModule from '../components/FeedbackModule.vue'
import TrainingModule from '../components/TrainingModule.vue'
import SuggestionModule from '../components/SuggestionModule.vue'

export default {
  name: 'Home',
  components: {
    QAModule,
    FeedbackModule,
    TrainingModule,
    SuggestionModule
  },
  data() {
    return {
      activeModule: 'qa'
    }
  },
  computed: {
    currentComponent() {
      const modules = {
        qa: 'QAModule',
        feedback: 'FeedbackModule',
        training: 'TrainingModule',
        suggestion: 'SuggestionModule'
      }
      return modules[this.activeModule]
    }
  }
}
</script>

<style scoped>
/* 确保根组件占满整个视口 */
.home-container {
  display: flex;
  flex-direction: column;
  width: 100vw; /* 新增：宽度充满屏幕 */
  height: 100vh;
  overflow: hidden;
  background: linear-gradient(135deg, #051036 0%, #0a1a40 100%); /* 藏蓝色深色渐变 */
  color: #fff;
  font-family: 'Arial', sans-serif;
}

/* 右侧内容区填满剩余空间 */
.content-area {
  flex: 1;
  padding: 20px;
  overflow: auto;
  height: calc(100% - 40px); /* 减去padding的高度 */
  box-sizing: border-box; /* 确保padding不影响整体高度计算 */
}

/* 顶部栏样式 */
.top-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 20px;
  height: 60px;
  background-color: rgba(0, 0, 0, 0.3);
  border-bottom: 1px solid rgba(255, 255, 255, 0.2);
}

.top-bar h1 {
  font-size: 22px;
  margin: 0;
}

.top-right {
  display: flex;
  align-items: center;
}

.top-right span {
  font-size: 14px;
  margin-right: 10px;
  opacity: 0.8;
}

.status-dot {
  display: inline-block;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background-color: #00ff00;
}

/* 主体区域样式 */
.main-content {
  display: flex;
  flex: 1;
  overflow: hidden;
}

/* 左侧模块栏样式 */
.sidebar {
  width: 220px;
  background-color: rgba(0, 0, 0, 0.2);
  padding: 20px 10px;
  box-sizing: border-box;
}

.sidebar h2 {
  font-size: 18px;
  margin-bottom: 20px;
  padding-left: 10px;
  border-left: 3px solid #00bcd4;
}

.module-item {
  padding: 15px;
  margin-bottom: 10px;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.module-item.active {
  background-color: #00bcd4;
  color: #fff;
}

.module-item:not(.active):hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.module-item i {
  display: inline-block;
  width: 24px;
  height: 24px;
  margin-right: 10px;
  vertical-align: middle;
  border-radius: 50%;
}

.icon-qa {
  background-color: #00bcd4;
}

.icon-feedback {
  background-color: #ff9800;
}

.icon-training {
  background-color: #4caf50;
}

.icon-suggestion {
  background-color: #9c27b0;
}

.module-item span {
  font-size: 16px;
  font-weight: 500;
  display: block;
  margin-bottom: 5px;
}

.module-item p {
  font-size: 12px;
  opacity: 0.8;
  margin: 0;
}

/* 右侧内容区样式 */
.content-area {
  flex: 1;
  padding: 20px;
  overflow: auto;
}
</style>