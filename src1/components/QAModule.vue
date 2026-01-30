<template>
  <div class="module-content qa-module">
    <!-- 模块标题与统计信息 -->
    <div class="qa-header">
      <div class="header-text">
        <h2>AI智能问答</h2>
        <p>智能搜索焊接安全知识，支持语音和多模态分析</p>
      </div>
      <div class="stats">
        <div class="stat-item">
          <span class="stat-value">{{ allQuestions.length }}</span>
          <span class="stat-label">总题目</span>
        </div>
        <div class="stat-item">
          <span class="stat-value">{{ categoryTags.length }}</span>
          <span class="stat-label">分类数</span>
        </div>
        <div class="stat-item">
          <span class="stat-value">128</span>
          <span class="stat-label">搜索次数</span>
        </div>
      </div>
    </div>

    <!-- 智能搜索区域 -->
    <div class="search-section">
      <h3>智能搜索</h3>
      <div class="search-bar">
        <input
            type="text"
            v-model="searchQuery"
            placeholder="输入问题，例如：焊接作业前需要检查哪些防护用品"
            @keyup.enter="handleSearch"
        />
        <button class="mic-btn" title="语音输入">
          <i class="icon-mic">🎤</i>
        </button>
        <!-- 加载状态禁用按钮+文字变化 -->
        <button class="search-btn" @click="handleSearch" :disabled="loading">
          {{ loading ? 'AI思考中...' : '搜索' }}
        </button>
        <!-- 新增：清空对话上下文按钮 -->
        <button class="clear-btn" @click="clearChatHistory" title="清空对话上下文">
          清空对话
        </button>
      </div>
    </div>

    <!-- AI多模态分析结果 -->
    <div class="analysis-result" v-if="showResult">
      <h3>AI多模态分析结果</h3>
      <div class="qa-pair">
        <p class="question">问题: {{ question }}</p>
        <p class="answer">答案: {{ answer }}</p>
      </div>
    </div>

    <!-- 知识分类 -->
    <div class="knowledge-category">
      <h3>知识分类</h3>
      <div class="category-tags">
        <button
            v-for="tag in categoryTags"
            :key="tag.value"
            :class="{ active: tag.value === activeTag }"
            @click="activeTag = tag.value"
        >
          {{ tag.label }}
        </button>
      </div>
      <button class="generate-btn" @click="generateNewQuestion">生成新题</button>
    </div>

    <!-- 问题列表 -->
    <div class="question-list">
      <h3>{{ activeTag }} - 问题列表</h3>
      <div class="question-item" v-for="(item, index) in filteredQuestions" :key="index">
        <p class="question-text">{{ item.question }}</p>
        <button
            class="toggle-answer-btn"
            @click="item.showAnswer = !item.showAnswer"
        >
          {{ item.showAnswer ? '隐藏答案' : '显示答案' }}
        </button>
        <div class="answer-tag">{{ item.category }}</div>
        <div class="answer-content" v-if="item.showAnswer">
          <p>{{ item.answer }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';
import axios from 'axios';

// ========== 核心修改：axios请求拦截器（加Token非空判断，避免传空值）==========
// 仅AI模块生效，有Token才加请求头，无Token则不设置，适配当前后端现状
axios.interceptors.request.use(
    (config) => {
      // 从本地存储获取token
      const token = localStorage.getItem('token');
      // 核心修改：有有效Token才添加Authorization头，无Token则不设置
      if (token && token !== 'undefined' && token !== 'null') {
        config.headers.Authorization = `Bearer ${token}`;
      }
      return config; // 必须返回配置，否则请求会中断
    },
    (error) => {
      // 请求前的错误处理（一般很少出现）
      return Promise.reject(error);
    }
);
// ===========================================================

// 配置后端AI接口基础路径 (根据文档来，无需修改)
const BASE_API_URL = 'http://localhost:9090/deepseek';

// 分类标签数据
const categoryTags = ref([
  { label: '焊接安全', value: '焊接安全' },
  { label: '焊接设备', value: '焊接设备' },
  { label: '焊接工艺', value: '焊接工艺' },
  { label: '焊接材料', value: '焊接材料' },
  { label: '焊接技巧', value: '焊接技巧' },
  { label: '焊接故障排除', value: '焊接故障排除' },
  { label: '焊接质量控制', value: '焊接质量控制' }
]);

// 激活的分类标签
const activeTag = ref('焊接安全');

// 问题数据
const allQuestions = ref([
  {category: '焊接安全',question: '焊接作业前需要检查哪些个人防护用品？',answer: '焊接作业前需检查的个人防护用品包括：焊接面罩（防弧光和飞溅）、阻燃焊接服（防高温和火花）、焊接手套（耐高温、防触电）、防护鞋（防砸、防滑、绝缘），以及根据情况佩戴的耳塞（防噪音）和呼吸防护设备（在通风不良环境中）。',showAnswer: false},
  {category: '焊接安全',question: '焊接场地的安全距离要求是多少？',answer: '焊接作业点与易燃易爆物品的安全距离不应小于5米，与氧气瓶、乙炔瓶等气瓶的安全距离不应小于10米。同时，作业区域周围应清理可燃物，必要时设置防火挡板或灭火器材。',showAnswer: false},
  {category: '焊接安全',question: '焊接时如何防止有害气体吸入？',answer: '确保作业场所通风良好，必要时使用局部排风装置；在密闭空间作业时必须佩戴呼吸防护器；采用低毒焊接材料；合理安排作业时间，避免长时间连续作业。',showAnswer: false},
  {category: '焊接设备',question: '电焊机日常维护要点有哪些？',answer: '定期清理灰尘、检查电缆接头、润滑运动部件、检查接地是否良好、保持通风口畅通、定期校准电流表和电压表、检查电极磨损情况并及时更换。',showAnswer: false},
  {category: '焊接设备',question: '如何选择合适的焊接电源？',answer: '根据焊接方法选择（手工电弧焊、氩弧焊等）、根据焊接材料厚度选择、根据工作环境选择（直流或交流）、考虑功率大小和便携性需求、参考焊条直径和焊接电流范围。',showAnswer: false},
  {category: '焊接工艺',question: '手工电弧焊的基本操作步骤是什么？',answer: '准备工作→引弧→运条→收弧→清理→检查质量。准备工作包括选择焊条、调整电流、清理工件；运条要控制好速度、角度和弧长。',showAnswer: false},
  {category: '焊接工艺',question: '埋弧焊与手工电弧焊相比较有哪些优势？',answer: '埋弧焊具有生产率高、焊缝质量好、劳动条件好、节约材料和电能等优势，适合于长焊缝和厚板焊接，但灵活性较差，不适用于短焊缝和复杂形状焊缝。',showAnswer: false},
  {category: '焊接材料',question: '焊条的药皮有什么作用？',answer: '焊条药皮的主要作用包括：保护电弧和熔池、脱氧和脱硫、添加合金元素、稳定电弧、改善焊缝成形等。不同类型的药皮适用于不同的焊接要求和场合。',showAnswer: false},
  {category: '焊接技巧',question: '如何避免焊接时产生咬边缺陷？',answer: '控制焊接电流不宜过大；保持适当的电弧长度；掌握正确的运条角度和速度；避免在坡口边缘停留时间过长；对于厚板焊接可采用多层多道焊。',showAnswer: false},
  {category: '焊接故障排除',question: '焊接时出现粘焊条现象的原因是什么？',answer: '主要原因包括：焊接电流过小；焊条角度不当；电弧长度过短；焊条质量问题；工件表面有油污或锈蚀；焊机输出电压不稳定等。',showAnswer: false},
  {category: '焊接质量控制',question: '焊接前的质量控制包括哪些内容？',answer: '焊接前质量控制包括：原材料检验（母材、焊条等）；焊接设备检查；坡口加工质量检查；工件装配质量检查；焊接工艺文件编制与审批；焊工资格审查等。',showAnswer: false}
]);

// 搜索相关数据
const searchQuery = ref('');
const question = ref('');
const answer = ref('');
const showResult = ref(false);
const loading = ref(false); // AI加载状态
const chatHistory = ref([]); // 多轮对话上下文，核心！适配chat接口的history参数

// 筛选当前分类的问题
const filteredQuestions = computed(() => {
  return allQuestions.value.filter(item => item.category === activeTag.value);
});

/**
 * 核心：AI智能搜索 - 对接后端 多轮对话接口 /api/deepseek/chat
 * 自带上下文记忆、加载状态、异常捕获、完整适配接口文档的返回格式
 */
const handleSearch = async () => {
  // 1. 校验输入内容
  const queryVal = searchQuery.value.trim();
  if (!queryVal) {
    alert('请输入焊接相关的提问内容！');
    return;
  }
  // 2. 加载中状态：禁用按钮+防止重复请求
  loading.value = true;
  showResult.value = false;
  question.value = queryVal;
  answer.value = '';

  try {
    // 3. 发起请求 - 完全匹配接口文档的请求体格式（拦截器自动判断是否加token）
    const res = await axios.post(`${BASE_API_URL}/chat`, {
      question: queryVal,
      history: chatHistory.value // 传入历史对话上下文，实现多轮连贯回答
    }, {
      headers: {
        'Content-Type': 'application/json' // 接口文档要求的请求头
      }
    });

    // 4. 接口返回数据处理 - 严格适配后端统一返回格式 code/msg/data
    const { code, msg, message, data } = res.data;
    // 核心修复1：后端返回的code是字符串"200"，改成字符串匹配
    if (code === "200") {
      answer.value = data; // AI回答内容直接渲染
      showResult.value = true;
      // 5. 追加到历史对话，供下一次提问使用
      chatHistory.value.push({
        question: queryVal,
        answer: data
      });
    } else {
      // 核心修复2：优先读取message字段，兼容msg
      answer.value = `提问失败：${message || msg || '未知错误'}`;
      showResult.value = true;
    }
  } catch (err) {
    // 网络异常/服务端500异常捕获
    console.error('AI接口请求异常：', err);
    // 核心修改：弱化401错误提示，适配当前后端未返回Token的现状，不删除Token、不提示登录过期
    if (err.response && err.response.status === 401) {
      answer.value = 'AI服务暂未完成鉴权配置，请稍后体验！';
    } else {
      answer.value = `服务异常，请稍后重试！${err.response?.data?.message || err.message || ''}`;
    }
    showResult.value = true;
  } finally {
    // 无论成功失败，关闭加载状态
    loading.value = false;
  }
};

/**
 * 备用：单轮问答接口调用方法 (如需切换为单轮问答，直接替换handleSearch里的调用即可)
 * 接口地址：/api/deepseek/ask  无上下文，每次请求独立
 */
const handleSingleAsk = async () => {
  const queryVal = searchQuery.value.trim();
  if (!queryVal) return;
  loading.value = true;
  showResult.value = false;
  question.value = queryVal;
  answer.value = '';
  try {
    const res = await axios.post(`${BASE_API_URL}/ask`, { question: queryVal }, {
      headers: { 'Content-Type': 'application/json' }
    });
    const { code, msg, message, data } = res.data;
    // 修复：字符串匹配code + 兼容message字段
    answer.value = code === "200" ? data : `提问失败：${message || msg || '未知错误'}`;
    showResult.value = true;
  } catch (err) {
    // 同步弱化401提示，和多轮对话保持一致
    if (err.response && err.response.status === 401) {
      answer.value = 'AI服务暂未完成鉴权配置，请稍后体验！';
    } else {
      answer.value = `服务异常，请稍后重试！${err.response?.data?.message || err.message || ''}`;
    }
    showResult.value = true;
  } finally {
    loading.value = false;
  }
};

// 清空多轮对话上下文
const clearChatHistory = () => {
  chatHistory.value = [];
  alert('已清空所有对话上下文，可重新发起新的提问！');
};

// 生成新题
const generateNewQuestion = () => {
  const newQuestion = {
    category: activeTag.value,
    question: `【新题】${activeTag.value}的专业问题${Math.floor(Math.random() * 100)}`,
    answer: `这是针对${activeTag.value}生成的专业解答内容，可根据实际业务需求进一步完善。`,
    showAnswer: false
  };
  allQuestions.value.push(newQuestion);
  alert(`已为【${activeTag.value}】生成新题`);
};
</script>

<style scoped>
.qa-module {
  padding: 20px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 8px;
  color: #e0e0e0;
}

.qa-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25px;
  padding-bottom: 15px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important;
}

.header-text p {
  color: #8892b0;
  margin-top: 5px !important;
}

.stats {
  display: flex;
  gap: 20px;
}

.stat-item {
  text-align: center;
}

.stat-value {
  font-size: 1.5rem;
  font-weight: bold;
  color: #64b5f6;
}

.stat-label {
  font-size: 0.8rem;
  color: #8892b0;
}

.search-section {
  margin-bottom: 25px;
}

.search-section h3 {
  margin-bottom: 12px !important;
  color: #ccd6f6;
}

.search-bar {
  display: flex;
  gap: 10px;
  margin-bottom: 10px;
}

.search-bar input {
  flex: 1;
  padding: 10px 15px !important;
  border-radius: 6px;
  background: #112240;
  color: white;
  border: 1px solid #2d4b7c !important;
}

.search-bar button {
  padding: 0 15px !important;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s;
  border: none;
}
/* 加载状态按钮样式 */
.search-bar button:disabled {
  background: #666;
  cursor: not-allowed;
  opacity: 0.7;
}

.mic-btn {
  background: #1a2c4c;
  color: #64b5f6;
}

.search-btn {
  background: #2d6bdc;
  color: white;
}
/* 清空对话按钮样式 */
.clear-btn {
  background: #d97706;
  color: white;
}

.analysis-result {
  margin-bottom: 25px;
  padding: 15px;
  background: #112240;
  border-radius: 8px;
}

.qa-pair {
  margin-top: 10px !important;
}

.question {
  color: #64b5f6;
  margin-bottom: 8px !important;
}

.answer {
  color: #b0b8c8;
  line-height: 1.6;
  white-space: pre-wrap; /* 解决AI回答换行不生效问题 */
}

.knowledge-category {
  margin-bottom: 25px;
}

.category-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-bottom: 15px !important;
}

.category-tags button {
  padding: 6px 15px !important;
  background: #1a2c4c;
  border: 1px solid #2d4b7c !important;
  border-radius: 20px;
  cursor: pointer;
  transition: all 0.2s;
  color: #e0e0e0;
}

.category-tags button.active {
  background: #2d6bdc;
  color: white;
  border-color: #4a80e0 !important;
}

.generate-btn {
  background: #10b981;
  color: white;
  padding: 8px 16px !important;
  border-radius: 6px;
  cursor: pointer;
  border: none;
}

.question-list {
  margin-top: 20px;
}

.question-item {
  background: #112240;
  border-radius: 8px;
  padding: 15px !important;
  margin-bottom: 12px !important;
  position: relative;
}

.question-text {
  margin-bottom: 10px !important;
  color: #e0e0e0;
}

.toggle-answer-btn {
  background: #1a2c4c;
  color: #64b5f6;
  padding: 4px 10px !important;
  border-radius: 4px;
  font-size: 0.8rem;
  cursor: pointer;
  margin-right: 10px !important;
  border: none;
}

.answer-tag {
  position: absolute;
  top: 15px;
  right: 15px;
  font-size: 0.8rem;
  color: #94a3b8;
  background: rgba(255, 255, 255, 0.05);
  padding: 2px 8px !important;
  border-radius: 4px;
}

.answer-content {
  margin-top: 10px !important;
  padding-top: 10px !important;
  border-top: 1px solid rgba(255, 255, 255, 0.1) !important;
  color: #b0b8c8;
  line-height: 1.6;
}
</style>