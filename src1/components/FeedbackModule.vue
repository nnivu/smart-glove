<template>
  <div class="error-feedback-module">
    <!-- 模块头部 -->
    <div class="module-header">
      <div class="header-left">
        <div class="alert-icon">
          <i class="icon-warning"></i>
        </div>
        <h2>错误收集与反馈</h2>
        <p>基于应急管理部官方数据的智能分析系统</p>
      </div>
      <div class="header-right">
        <div class="filter-select">
          <select v-model="timeRange">
            <option value="month">本月</option>
            <option value="quarter">本季度</option>
            <option value="year">本年</option>
          </select>
        </div>
        <button class="export-btn">导出报告</button>
        <div class="monitor-status">
          <span class="status-text">监控状态：</span>
          <span class="status-active">实时监控中</span>
          <span class="status-dot"></span>
        </div>
      </div>
    </div>

    <!-- 全国安全生产形势统计 -->
    <div class="safety-trend">
      <div class="trend-title">
        <span>2024年全国安全生产形势</span>
        <span class="official-tag">官方数据</span>
        <a href="#" class="external-link">
          <i class="icon-link"></i>
        </a>
      </div>
      <div class="trend-stats">
        <div class="stat-item">
          <span class="stat-value">21,800</span>
          <span class="stat-label">总事故数</span>
          <span class="stat-change up">+11%</span>
        </div>
        <div class="stat-item">
          <span class="stat-value">19,600</span>
          <span class="stat-label">死亡人数</span>
          <span class="stat-change down">-7.6%</span>
        </div>
        <div class="stat-item">
          <span class="stat-value">389</span>
          <span class="stat-label">较大事故</span>
          <span class="stat-change up">+10.0%</span>
        </div>
        <div class="stat-item">
          <span class="stat-value">9</span>
          <span class="stat-label">重特大事故</span>
          <span class="stat-change up">+43.8%</span>
        </div>
      </div>
      <div class="data-source">
        数据来源：应急管理部2025年1月15日发布 | 最后更新：2025-01-15
      </div>
    </div>

    <!-- 核心指标卡片 -->
    <div class="core-indicators">
      <div class="indicator-card">
        <span class="card-value">310</span>
        <span class="card-label">总错误数</span>
        <p class="card-desc">基于2023年机械行业数据</p>
        <div class="card-alert">
          <i class="icon-alert"></i>
        </div>
      </div>
      <div class="indicator-card">
        <span class="card-value">294</span>
        <span class="card-label">涉及人员</span>
        <p class="card-desc">死亡人数统计</p>
        <div class="card-people">
          <i class="icon-people"></i>
        </div>
      </div>
      <div class="indicator-card">
        <span class="card-value">-15%</span>
        <span class="card-label">本月趋势</span>
        <p class="card-desc">环比改善</p>
        <div class="card-trend up">
          <i class="icon-trend-up"></i>
        </div>
      </div>
      <div class="indicator-card">
        <span class="card-value">1.8h</span>
        <span class="card-label">平均响应</span>
        <p class="card-desc">应急响应时间</p>
        <div class="card-time">
          <i class="icon-time"></i>
        </div>
      </div>
    </div>

    <!-- 风险矩阵分析 -->
    <div class="risk-analysis">
      <div class="analysis-header">
        <span class="analysis-title">风险矩阵分析</span>
        <span class="analysis-tag">企业决策支持</span>
      </div>
      <div class="analysis-content">
        <div class="radar-chart">
          <!-- 雷达图容器 -->
          <div class="radar-placeholder" ref="radarChartRef"></div>
        </div>
        <div class="risk-list">
          <div class="risk-item">
            <span class="risk-name">化学品泄漏</span>
            <span class="risk-rate">发生概率: 85%</span>
            <span class="risk-impact">影响程度: 95%</span>
            <span class="risk-score up">风险分值: 80.75</span>
          </div>
          <div class="risk-item">
            <span class="risk-name">设备故障</span>
            <span class="risk-rate">发生概率: 70%</span>
            <span class="risk-impact">影响程度: 80%</span>
            <span class="risk-score up">风险分值: 56</span>
          </div>
          <div class="risk-item">
            <span class="risk-name">人员违规</span>
            <span class="risk-rate">发生概率: 90%</span>
            <span class="risk-impact">影响程度: 60%</span>
            <span class="risk-score down">风险分值: 54</span>
          </div>
          <div class="risk-item">
            <span class="risk-name">环境因素</span>
            <span class="risk-rate">发生概率: 65%</span>
            <span class="risk-impact">影响程度: 75%</span>
            <span class="risk-score up">风险分值: 48.75</span>
          </div>
          <div class="risk-item">
            <span class="risk-name">管理缺失</span>
            <span class="risk-rate">发生概率: 80%</span>
            <span class="risk-impact">影响程度: 85%</span>
            <span class="risk-score up">风险分值: 68</span>
          </div>
        </div>
      </div>
    </div>

    <!-- 仪表盘内容 -->
    <div class="dashboard">
      <!-- 第一行模块 -->
      <div class="row">
        <!-- 错误类型统计 -->
        <div class="module">
          <div class="module-header">
            <h3>错误类型统计</h3>
            <span>应急管理部数据</span>
          </div>
          <div ref="errorTypeChart" class="chart-container"></div>
        </div>

        <!-- 严重程度分布 -->
        <div class="module">
          <div class="module-header">
            <h3>严重程度分布</h3>
            <span>实时监控</span>
          </div>
          <!-- 修改为上下布局 -->
          <div class="chart-column">
            <div ref="severityPieChart" class="chart-container"></div>
            <div class="risk-list">
              <div class="risk-item" :class="['low', 'risk']">
                <span>低风险 35%</span>
                <p>轻微违规操作</p>
                <p>主要原因：</p>
                <p>· 操作流程不规范</p>
                <p>· 个人防护意识薄弱</p>
                <p>· 安全检查缺失</p>
              </div>
              <div class="risk-item" :class="['medium', 'risk']">
                <span>中风险 40%</span>
                <p>设备使用不当</p>
                <p>主要原因：</p>
                <p>· 设备维护不及时</p>
                <p>· 操作技能不熟练</p>
                <p>· 安全培训不到位</p>
              </div>
              <div class="risk-item" :class="['high', 'risk']">
                <span>高风险 20%</span>
                <p>安全防护缺失</p>
                <p>主要原因：</p>
                <p>· 防护设备老化</p>
                <p>· 应急预案不完善</p>
                <p>· 管理制度缺失</p>
              </div>
              <div class="risk-item" :class="['critical', 'risk']">
                <span>严重风险 5%</span>
                <p>生命安全威胁</p>
                <p>主要原因：</p>
                <p>· 有毒气体泄漏</p>
                <p>· 电气安全隐患</p>
                <p>· 火灾爆炸风险</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 第二行模块 -->
      <div class="row">
        <!-- 趋势预测分析 -->
        <div class="module">
          <div class="module-header">
            <h3>趋势预测分析</h3>
            <span>AI预测</span>
          </div>
          <div ref="trendChart" class="chart-container"></div>
        </div>

        <!-- AI智能分析 -->
        <div class="module">
          <div class="module-header">
            <h3>AI智能分析</h3>
            <span>DeepSeek AI</span>
          </div>
          <div class="analysis-content">
            <ul>
              <li>
                <strong>**基于2024年应急管理部官方数据的智能分析**</strong>
              </li>
              <li>
                <strong>**全国安全生产形势**</strong>
              </li>
              <li>2024年全国生产安全事故21,800起，同比下降11%</li>
              <li>死亡人数19,600人，同比下降7.6%，首次降至2万人以下</li>
              <li>重特大事故9起，同比下降43.8%，历史性突破</li>
              <li>
                <strong>**本企业风险态势评估**</strong>
              </li>
              <li>当前焊接作业风险等级：中高风险</li>
            </ul>
          </div>
        </div>
      </div>

      <!-- 第三行模块 -->
      <div class="row">
        <!-- 成本效益分析 -->
        <div class="module">
          <div class="module-header">
            <h3>成本效益分析</h3>
            <span>企业决策</span>
          </div>
          <div class="chart-row">
            <!-- 添加了chart-narrow类来限制图表宽度 -->
            <div ref="costBenefitChart" class="chart-container chart-narrow"></div>
            <div class="analysis-panel">
              <div class="investment-analysis">
                <h4>投资回报率分析</h4>
                <p>总预防投入：<span class="highlight">275,000元</span></p>
                <p>潜在损失：<span class="highlight">3,850,000元</span></p>
                <p>投资回报率：<span class="highlight">1:14</span></p>
              </div>
              <div class="risk-level">
                <h4>风险等级分布</h4>
                <ul>
                  <li><span class="low">低风险</span> 50.0万元</li>
                  <li><span class="medium">中风险</span> 120.0万元</li>
                  <li><span class="high">高风险</span> 250.0万元</li>
                  <li><span class="critical">严重风险</span> 500.0万元</li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 实时错误反馈 -->
      <div class="module">
        <div class="module-header">
          <h3>实时错误反馈</h3>
          <span class="real-time">实时</span>
        </div>
        <div class="feedback-list">
          <div class="feedback-item">
            <div class="item-header">
              <span class="risk-indicator low"></span>
              <span>赵六 · 生产一部 · 晚班</span>
            </div>
            <p>喷涂作业区温度过高</p>
            <p>车间C-喷涂线 设备: EQ-457</p>
            <div class="risk-meta">
              <span class="risk-tag low">低风险</span>
              <span>67%</span>
              <span>刚刚</span>
            </div>
          </div>
          <div class="feedback-item">
            <div class="item-header">
              <span class="risk-indicator critical"></span>
              <span>张三 · 生产一部 · 早班</span>
            </div>
            <p>焊接房内未佩戴防护面具</p>
            <p>车间A-焊接房1 设备: SP-001</p>
            <div class="risk-meta">
              <span class="risk-tag critical">严重风险</span>
              <span>95%</span>
              <span>2分钟前</span>
            </div>
          </div>
          <div class="feedback-item">
            <div class="item-header">
              <span class="risk-indicator critical"></span>
              <span>李四 · 生产二部 · 早班</span>
            </div>
            <p>调漆间排风设施未开启</p>
            <p>车间B-调漆间 设备: TQ-002</p>
            <div class="risk-meta">
              <span class="risk-tag critical">严重风险</span>
              <span>92%</span>
              <span>5分钟前</span>
            </div>
          </div>
        </div>
      </div>
    </div>




  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import * as echarts from 'echarts';

// 时间范围筛选
const timeRange = ref('month');

// 图表容器引用
const errorTypeChart = ref(null);
const severityPieChart = ref(null);
const trendChart = ref(null);
const costBenefitChart = ref(null);
const radarChartRef = ref(null);

// 风险数据（与右侧列表数据对应）
const riskData = [
  { name: '化学品泄漏', probability: 85, impact: 95 },
  { name: '设备故障', probability: 70, impact: 80 },
  { name: '人员违规', probability: 90, impact: 60 },
  { name: '环境因素', probability: 65, impact: 75 },
  { name: '管理缺失', probability: 80, impact: 85 }
];

onMounted(() => {
  // 初始化错误类型统计图表
  const errorTypeInstance = echarts.init(errorTypeChart.value);
  errorTypeInstance.setOption({
    color: '#4895ef',
    xAxis: {
      type: 'category',
      data: ['机械伤害', '物体打击', '高处坠落', '触电事故', '中毒窒息', '焊接燃烧', '环境防护']
    },
    yAxis: {
      type: 'value',
      max: 100
    },
    series: [{
      type: 'bar',
      data: [90, 65, 45, 40, 35, 30, 10]
    }],
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      top: '15%',
      containLabel: true
    }
  });

  // 初始化严重程度分布图表
  const severityPieInstance = echarts.init(severityPieChart.value);
  severityPieInstance.setOption({
    color: ['#4ade80', '#fbbc05', '#ef4444', '#dc2626'],
    series: [{
      type: 'pie',
      radius: ['40%', '70%'],
      data: [
        { value: 35, name: '低风险' },
        { value: 40, name: '中风险' },
        { value: 20, name: '高风险' },
        { value: 5, name: '严重风险' }
      ],
      label: {
        show: false
      },
      labelLine: {
        show: false
      }
    }]
  });

  // 初始化趋势预测分析图表
  const trendInstance = echarts.init(trendChart.value);
  trendInstance.setOption({
    color: ['#4895ef', '#4ade80'],
    xAxis: {
      type: 'category',
      data: ['1月', '2月', '3月', '4月', '5月', '6月']
    },
    yAxis: {
      type: 'value',
      max: 60
    },
    series: [
      {
        type: 'line',
        data: [45, 48, 55, 42, 38, 45],
        symbol: 'circle',
        symbolSize: 8,
        lineStyle: {
          width: 2
        }
      },
      {
        type: 'line',
        data: [42, 38, 42, 35, 30, 32],
        symbol: 'circle',
        symbolSize: 8,
        lineStyle: {
          width: 2,
          type: 'dashed'
        }
      }
    ],
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      top: '15%',
      containLabel: true
    }
  });

  // 初始化成本效益分析图表
  const costBenefitInstance = echarts.init(costBenefitChart.value);
  costBenefitInstance.setOption({
    color: ['#1a2c4c', '#ef4444'],
    xAxis: {
      type: 'category',
      data: ['机械伤害', '物体打击', '高处坠落', '触电事故', '中毒窒息', '焊接燃烧', '环境防护']
    },
    yAxis: {
      type: 'value',
      max: 1000
    },
    series: [
      {
        type: 'bar',
        name: '预防投入',
        data: [50, 30, 40, 30, 40, 20, 10]
      },
      {
        type: 'bar',
        name: '潜在损失',
        data: [550, 350, 450, 500, 800, 950, 250]
      }
    ],
    grid: {
      left: '3%',
      right: '4%',
      bottom: '3%',
      top: '15%',
      containLabel: true
    },
    legend: {
      show: false
    }
  });

  // 初始化雷达图
  const radarChart = echarts.init(radarChartRef.value);
  const radarOption = {
    tooltip: {
      trigger: 'item'
    },
    legend: {
      top: 0,
      data: ['发生概率', '影响程度'],
      textStyle: {
        color: '#e0e0e0' // 图例文字颜色
      }
    },
    radar: {
      // 调整雷达图大小（通过内外半径控制）
      radius: '85%', // 增大雷达图半径（相对于容器）
      center: ['50%', '55%'], // 调整位置，避免顶部图例遮挡
      indicator: riskData.map(item => ({
        name: item.name,
        max: 100 // 最大值设为100，因为数据是百分比
      })),
      splitArea: {
        areaStyle: {
          color: ['rgba(255, 255, 255, 0.05)']
        }
      },
      axisLine: {
        lineStyle: {
          color: '#8892b0'
        }
      },
      name: {
        textStyle: {
          color: '#8892b0',
          fontSize: 12 // 适当增大标签字体
        }
      }
    },
    series: [
      {
        name: '风险评估',
        type: 'radar',
        symbol: 'circle',
        symbolSize: 8, // 增大数据点
        lineStyle: {
          width: 3 // 加粗线条
        },
        emphasis: {
          areaStyle: {
            color: 'rgba(255, 0, 0, 0.3)' // 红色高亮
          }
        },
        data: [
          {
            value: riskData.map(item => item.probability),
            name: '发生概率',
            itemStyle: {
              color: '#ff0000' // 红色
            },
            areaStyle: {
              color: 'rgba(255, 0, 0, 0.2)' // 红色半透明
            }
          },
          {
            value: riskData.map(item => item.impact),
            name: '影响程度',
            itemStyle: {
              color: '#0000ff' // 蓝色
            },
            areaStyle: {
              color: 'rgba(0, 0, 255, 0.2)' // 蓝色半透明
            }
          }
        ]
      }
    ]
  };
  radarChart.setOption(radarOption);

  // 监听窗口大小变化
  window.addEventListener('resize', () => {
    errorTypeInstance.resize();
    severityPieInstance.resize();
    trendInstance.resize();
    costBenefitInstance.resize();
    radarChart.resize();
  });
});
</script>

<style scoped>
/* 原有样式保持不变 */
.error-feedback-module {
  padding: 20px;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 8px;
  color: #e0e0e0;
}

/* 模块头部样式 */
.module-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 15px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1) !important;
}

.header-left {
  display: flex;
  align-items: center;
}

.alert-icon {
  width: 40px;
  height: 40px;
  background: #ff5252;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-right: 15px;
}

.alert-icon i {
  color: white;
  font-size: 1.2rem;
}

.header-left h2 {
  margin: 0 !important;
  font-size: 1.5rem;
}

.header-left p {
  color: #8892b0;
  margin-top: 5px !important;
  font-size: 0.9rem;
}

.header-right {
  display: flex;
  align-items: center;
  gap: 15px;
}

.filter-select select {
  background: #1a2c4c;
  border: 1px solid #2d4b7c;
  color: #e0e0e0;
  padding: 8px 12px;
  border-radius: 4px;
  cursor: pointer;
}

.export-btn {
  background: #2d6bdc;
  color: white;
  border: none;
  padding: 8px 15px;
  border-radius: 4px;
  cursor: pointer;
}

.monitor-status {
  display: flex;
  align-items: center;
  gap: 5px;
}

.status-text {
  color: #8892b0;
  font-size: 0.9rem;
}

.status-active {
  color: #4ade80;
  font-size: 0.9rem;
}

.status-dot {
  display: inline-block;
  width: 10px;
  height: 10px;
  background: #4ade80;
  border-radius: 50%;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
}

/* 仪表盘样式 */
.dashboard {
  padding: 10px 0;
  background: transparent;
  color: #e2e8f0;
  font-family: 'Inter', sans-serif;
  margin-bottom: 20px;
}

.row {
  display: flex;
  gap: 20px;
  margin-bottom: 20px;
}

.module {
  background: #1e293b;
  border-radius: 8px;
  padding: 15px;
  flex: 1;
}

.module-header h3 {
  margin: 0;
  font-size: 1.2rem;
}

.module-header span {
  font-size: 0.9rem;
  color: #94a3b8;
}

.chart-container {
  width: 100%;
  height: 250px;
}

/* 新增：垂直布局容器 */
.chart-column {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

/* 原有水平布局容器保持不变 */
.chart-row {
  display: flex;
  gap: 20px;
}

/* 新增：限制成本效益分析图表宽度 */
.chart-narrow {
  width: 60%;
}

.risk-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
  flex: 1;
}

.risk-item {
  background: #1a2c4c;
  border-radius: 6px;
  padding: 10px;
}

.risk-item span {
  font-weight: bold;
  display: block;
  margin-bottom: 5px;
}

.risk-item p {
  margin: 0;
  font-size: 0.9rem;
  color: #cbd5e1;
  line-height: 1.5;
}

.low {
  color: #4ade80;
}

.medium {
  color: #fbbc05;
}

.high {
  color: #ef4444;
}

.critical {
  color: #dc2626;
}

.analysis-content {
  padding: 10px;
}

.analysis-content ul {
  list-style-type: none;
  padding: 0;
}

.analysis-content li {
  margin-bottom: 8px;
  line-height: 1.6;
}

.analysis-panel {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.investment-analysis, .risk-level {
  background: #1a2c4c;
  border-radius: 6px;
  padding: 10px;
}

.investment-analysis .highlight {
  font-weight: bold;
  color: #4ade80;
}

.risk-level ul {
  list-style-type: none;
  padding: 0;
}

.risk-level li {
  margin-bottom: 5px;
}

.feedback-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.feedback-item {
  background: #1a2c4c;
  border-radius: 6px;
  padding: 10px;
}

.item-header {
  display: flex;
  align-items: center;
  margin-bottom: 8px;
}

.risk-indicator {
  display: inline-block;
  width: 10px;
  height: 10px;
  border-radius: 50%;
  margin-right: 8px;
}

.feedback-item p {
  margin: 0 0 8px 0;
  font-size: 0.9rem;
  color: #cbd5e1;
}

.risk-meta {
  display: flex;
  justify-content: space-between;
  font-size: 0.8rem;
  color: #94a3b8;
}

.risk-tag {
  padding: 2px 6px;
  border-radius: 4px;
  font-size: 0.7rem;
  font-weight: bold;
}

.real-time {
  background: #dc2626;
  color: white;
  padding: 2px 6px;
  border-radius: 4px;
  font-size: 0.8rem;
}

/* 安全生产形势统计样式 */
.safety-trend {
  background: linear-gradient(135deg, #2a0f55, #4a148c);
  border-radius: 8px;
  padding: 20px;
  margin-bottom: 20px;
}

.trend-title {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 15px;
}

.official-tag {
  background: #2d6bdc;
  color: white;
  font-size: 0.8rem;
  padding: 3px 8px;
  border-radius: 4px;
}

.external-link {
  color: #8892b0;
  font-size: 1.2rem;
}

.trend-stats {
  display: flex;
  justify-content: space-between;
  margin-bottom: 15px;
}

.stat-item {
  text-align: center;
}

.stat-value {
  font-size: 2rem;
  font-weight: bold;
  color: white;
  display: block;
}

.stat-label {
  color: #bbdefb;
  font-size: 0.9rem;
  display: block;
  margin-top: 5px;
}

.stat-change {
  font-size: 0.8rem;
  display: block;
  margin-top: 3px;
}

.stat-change.up {
  color: #ff5252;
}

.stat-change.down {
  color: #4ade80;
}

.data-source {
  color: #bbdefb;
  font-size: 0.8rem;
  text-align: right;
}

/* 核心指标卡片样式 */
.core-indicators {
  display: flex;
  justify-content: space-between;
  gap: 15px;
  margin-bottom: 20px;
}

.indicator-card {
  flex: 1;
  background: #1a2c4c;
  border-radius: 8px;
  padding: 15px;
  display: flex;
  flex-direction: column;
}

.card-value {
  font-size: 1.8rem;
  font-weight: bold;
  color: white;
  margin-bottom: 5px;
  display: block;
}

.card-label {
  color: #8892b0;
  font-size: 0.9rem;
  margin-bottom: 8px;
  display: block;
}

.card-desc {
  color: #bbdefb;
  font-size: 0.8rem;
  margin: 0 !important;
  flex: 1;
}

.card-alert {
  width: 30px;
  height: 30px;
  background: #ff5252;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
}

.card-people {
  width: 30px;
  height: 30px;
  background: #2d6bdc;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
}

.card-trend {
  width: 30px;
  height: 30px;
  background: #4ade80;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
}

.card-trend.up i {
  transform: rotate(45deg);
}

.card-time {
  width: 30px;
  height: 30px;
  background: #7e57c2;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
}

/* 风险矩阵分析样式 */
.risk-analysis {
  background: #1a2c4c;
  border-radius: 8px;
  padding: 15px;
}

.analysis-header {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 15px;
}

.analysis-title {
  font-size: 1.2rem;
  font-weight: bold;
}

.analysis-tag {
  background: #9c27b0;
  color: white;
  font-size: 0.8rem;
  padding: 3px 8px;
  border-radius: 4px;
}

.analysis-content {
  display: flex;
  gap: 20px;
}

/* 雷达图放大：增加容器高度 */
.radar-chart {
  flex: 1;
  position: relative;
  height: 350px; /* 从250px增加到350px */
}

.radar-placeholder {
  position: relative;
  width: 100%;
  height: 100%;
}

.risk-list {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.risk-item {
  background: #112240;
  border-radius: 6px;
  padding: 10px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.risk-name {
  font-weight: bold;
  color: white;
}

.risk-rate, .risk-impact {
  color: #8892b0;
  font-size: 0.9rem;
}

.risk-score {
  font-size: 0.9rem;
}

.risk-score.up {
  color: #ff5252;
}

.risk-score.down {
  color: #4ade80;
}
</style>