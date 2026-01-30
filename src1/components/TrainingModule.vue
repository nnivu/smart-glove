<template>
  <div class="ai-welding-training">
    <!-- 头部区域 -->
    <div class="header">
      <div class="title-section">
        <h2>姿态训练模拟</h2>
        <p>基于姿态数据集的智能姿态分析系统</p>
      </div>
      <div class="header-actions">
        <select class="select-control">
          <option value="Pose-Detection">Pose-Detection</option>
        </select>
        <button class="export-btn">导出数据</button>
        <span class="monitor-status">监控状态：已停止</span>
      </div>
    </div>

    <!-- 数据概览区域 -->
    <div class="data-overview">
      <div class="data-card">
        <p class="data-value">200K</p>
        <p class="data-label">标注图像<br/>训练数据</p>
      </div>
      <div class="data-card">
        <p class="data-value">17</p>
        <p class="data-label">关键点<br/>人体骨架</p>
      </div>
      <div class="data-card">
        <p class="data-value">96.8%</p>
        <p class="data-label">准确率<br/>模型性能</p>
      </div>
      <div class="data-card">
        <p class="data-value">v2.1</p>
        <p class="data-label">模型版本<br/>最新版本</p>
      </div>
    </div>

    <!-- 状态卡片区域 -->
    <div class="status-cards">
      <div class="status-card">
        <div class="status-info">
          <p class="status-title">姿态评分</p>
          <p class="status-value">85</p>
          <p class="status-desc">基于姿态关键点</p>
        </div>
        <div class="status-icon blue"></div>
      </div>
      <div class="status-card">
        <div class="status-info">
          <p class="status-title">风险等级</p>
          <p class="status-value">中</p>
          <p class="status-desc">实时评估</p>
        </div>
        <div class="status-icon orange"></div>
      </div>
      <div class="status-card">
        <div class="status-info">
          <p class="status-title">训练进度</p>
          <p class="status-value">37%</p>
          <p class="status-desc">ExpertAI 组</p>
        </div>
        <div class="status-icon green"></div>
      </div>
      <div class="status-card">
        <div class="status-info">
          <p class="status-title">设备状态</p>
          <p class="status-value">已连接</p>
          <p class="status-desc">智能手套</p>
        </div>
        <div class="status-icon purple"></div>
      </div>
    </div>

    <!-- 中控区域 -->
    <div class="control-area">
      <div class="control-card">
        <h3>监控控制</h3>
        <button class="start-btn">开始监控</button>
        <button class="reset-btn">重置训练</button>
        <div class="progress-bar">
          <div class="progress" style="width: 0%"></div>
          <p class="progress-text">训练进度 0%</p>
        </div>
      </div>
      <div class="control-card">
        <h3>实时姿态 <span class="pose-tag">Pose-17</span></h3>
        <div class="pose-display">
          <!-- 实时姿态图区域 -->
          <div class="placeholder-img"></div>
          <div class="status-legend">
            <span class="legend-item green">正常</span>
            <span class="legend-item yellow">警告</span>
            <span class="legend-item red">危险</span>
          </div>
        </div>
      </div>
      <div class="control-card">
        <h3>当前状态</h3>
        <ul class="status-list">
          <li><span>手臂角度</span><span>45°</span></li>
          <li><span>腕部位置</span><span class="status-normal">normal</span></li>
          <li><span>身体姿态</span><span class="status-stable">stable</span></li>
          <li><span>喷涂距离</span><span>25cm</span></li>
          <li><span>喷涂角度</span><span>90°</span></li>
          <li><span>压力值</span><span>2.5bar</span></li>
          <li><span>综合评分</span><span class="score">87/100</span></li>
        </ul>
      </div>
    </div>

    <!-- 标准姿态参考区 -->
    <div class="reference-section">
      <div class="section-header">
        <h2>标准姿态参考</h2>
        <span class="safety-tag">安全操作</span>
      </div>

      <div class="reference-cards">
        <!-- 标准焊接姿态 -->
        <div class="reference-card">
          <img src="/images/pic1.jpg" alt="标准焊接姿态" class="reference-img">
          <h3>标准焊接姿态</h3>
          <p>正确的身体姿态和手臂角度</p>
        </div>

        <!-- 防护设备佩戴 -->
        <div class="reference-card">
          <img src="/images/pic2.jpg" alt="防护设备佩戴" class="reference-img">
          <h3>防护设备佩戴</h3>
          <p>完整的个人防护装备</p>
        </div>

        <!-- 关键点检测 -->
        <div class="reference-card">
          <img src="/images/pic3.jpg" alt="关键点检测" class="reference-img">
          <h3>关键点检测</h3>
          <p>Pose-17关键标志点示例</p>
        </div>
      </div>
    </div>

    <!-- 分析区域 -->
    <div class="analysis-section">
      <!-- 实时趋势分析 -->
      <div class="analysis-card">
        <div class="analysis-header">
          <i class="trend-icon"></i>
          <h3>实时趋势分析</h3>
        </div>
        <div class="chart-container" ref="trendChartRef"></div>
      </div>

      <!-- 姿态对比分析 -->
      <div class="analysis-card">
        <div class="analysis-header">
          <i class="comparison-icon"></i>
          <h3>姿态对比分析</h3>
        </div>
        <div class="chart-container" ref="radarChartRef"></div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import * as echarts from 'echarts';

// 图表容器引用
const trendChartRef = ref(null);
const radarChartRef = ref(null);

// 初始化图表
onMounted(() => {
  // 初始化实时趋势图
  initTrendChart();
  // 初始化姿态对比雷达图
  initRadarChart();
});

// 实时趋势分析图表 - 使用静态数据，不随时间变化
const initTrendChart = () => {
  const trendChart = echarts.init(trendChartRef.value);

  // 时间数据保持静态
  const timeData = ['14:30', '14:32', '14:34', '14:36', '14:38', '14:40'];

  // 配置项 - 使用固定数据
  const option = {
    backgroundColor: '#1a202c',
    tooltip: {
      trigger: 'axis',
      backgroundColor: 'rgba(30, 41, 59, 0.8)',
      borderColor: '#334155',
      borderWidth: 1,
      textStyle: { color: '#e2e8f0' }
    },
    grid: {
      left: '5%',
      right: '5%',
      bottom: '10%',
      top: '15%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      data: timeData,
      axisLine: { lineStyle: { color: '#475569' } },
      axisLabel: { color: '#94a3b8' }
    },
    yAxis: {
      type: 'value',
      min: 0,
      max: 100,
      axisLine: { lineStyle: { color: '#475569' } },
      axisLabel: { color: '#94a3b8' },
      splitLine: { lineStyle: { color: 'rgba(71, 85, 105, 0.3)' } }
    },
    series: [
      {
        data: [98, 92, 88, 82, 85, 90],
        type: 'line',
        smooth: true,
        areaStyle: {
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            { offset: 0, color: 'rgba(6, 182, 212, 0.6)' },
            { offset: 1, color: 'rgba(6, 182, 212, 0.1)' }
          ])
        },
        lineStyle: {
          width: 3,
          color: 'rgba(6, 182, 212, 1)'
        },
        symbol: 'circle',
        symbolSize: 6,
        itemStyle: {
          color: '#06b6d4'
        }
      }
    ]
  };

  trendChart.setOption(option);

  // 响应窗口大小变化
  window.addEventListener('resize', () => {
    trendChart.resize();
  });
};

// 姿态对比分析雷达图 - 静态数据
const initRadarChart = () => {
  const radarChart = echarts.init(radarChartRef.value);

  // 配置项 - 使用固定数据
  const option = {
    backgroundColor: '#1a202c',
    tooltip: {
      trigger: 'item',
      backgroundColor: 'rgba(30, 41, 59, 0.8)',
      borderColor: '#334155',
      textStyle: { color: '#e2e8f0' }
    },
    radar: {
      indicator: [
        { name: '头部位置', max: 100 },
        { name: '肩部平衡', max: 100 },
        { name: '手臂角度', max: 100 },
        { name: '腰部姿态', max: 100 },
        { name: '腿部稳定', max: 100 },
        { name: '整体协调', max: 100 }
      ],
      splitArea: {
        areaStyle: {
          color: ['rgba(71, 85, 105, 0.1)', 'rgba(71, 85, 105, 0.2)']
        }
      },
      axisLine: {
        lineStyle: { color: '#475569' }
      },
      splitLine: {
        lineStyle: { color: 'rgba(71, 85, 105, 0.3)' }
      },
      name: {
        textStyle: { color: '#94a3b8' }
      }
    },
    series: [
      {
        name: '姿态对比',
        type: 'radar',
        symbol: 'circle',
        symbolSize: 5,
        lineStyle: { width: 2 },
        emphasis: { lineStyle: { width: 3 } },
        data: [
          {
            name: '当前姿态',
            value: [80, 75, 65, 85, 90, 78],
            itemStyle: { color: 'rgba(59, 130, 246, 0.8)' },
            lineStyle: { color: 'rgba(59, 130, 246, 0.8)' },
            areaStyle: { color: 'rgba(59, 130, 246, 0.2)' }
          },
          {
            name: '标准姿态',
            value: [95, 90, 85, 90, 95, 92],
            itemStyle: { color: 'rgba(16, 185, 129, 0.8)' },
            lineStyle: { color: 'rgba(16, 185, 129, 0.8)' },
            areaStyle: { color: 'rgba(16, 185, 129, 0.2)' }
          }
        ]
      }
    ]
  };

  radarChart.setOption(option);

  // 响应窗口大小变化
  window.addEventListener('resize', () => {
    radarChart.resize();
  });
};
</script>

<style scoped>
.ai-welding-training {
  background-color: #1e293b;
  color: #e2e8f0;
  padding: 20px;
  font-family: "Microsoft YaHei", sans-serif;
  height: 100%;
  box-sizing: border-box;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.title-section h2 {
  font-size: 24px;
  margin: 0;
}

.title-section p {
  font-size: 14px;
  color: #94a3b8;
  margin: 0;
}

.header-actions {
  display: flex;
  gap: 15px;
  align-items: center;
}

.select-control {
  background-color: #2d3748;
  color: #e2e8f0;
  border: none;
  padding: 6px 10px;
  border-radius: 4px;
}

.export-btn {
  background-color: #7c3aed;
  color: white;
  border: none;
  padding: 6px 12px;
  border-radius: 4px;
  cursor: pointer;
}

.monitor-status {
  font-size: 14px;
  color: #94a3b8;
}

.data-overview {
  display: flex;
  justify-content: space-between;
  background-color: #3b2e7a;
  padding: 20px;
  border-radius: 8px;
  margin-bottom: 20px;
}

.data-card {
  text-align: center;
  flex: 1;
}

.data-value {
  font-size: 28px;
  font-weight: bold;
  margin: 0;
}

.data-label {
  font-size: 12px;
  color: #94a3b8;
  margin: 0;
  line-height: 1.5;
}

.status-cards {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
  gap: 10px;
}

.status-card {
  flex: 1;
  background-color: #2d3748;
  padding: 16px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  gap: 10px;
}

.status-info {
  flex: 1;
}

.status-title {
  font-size: 14px;
  color: #94a3b8;
  margin: 0 0 4px 0;
}

.status-value {
  font-size: 20px;
  font-weight: bold;
  margin: 0 0 4px 0;
}

.status-desc {
  font-size: 12px;
  color: #94a3b8;
  margin: 0;
}

.status-icon {
  width: 32px;
  height: 32px;
  border-radius: 50%;
}

.blue {
  background-color: #2563eb;
}

.orange {
  background-color: #f59e0b;
}

.green {
  background-color: #10b981;
}

.purple {
  background-color: #7c3aed;
}

.control-area {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
  gap: 10px;
}

.control-card {
  flex: 1;
  background-color: #2d3748;
  padding: 16px;
  border-radius: 8px;
}

.control-card h3 {
  font-size: 16px;
  margin: 0 0 15px 0;
}

.start-btn {
  background-color: #10b981;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  display: block;
  width: 100%;
  margin-bottom: 10px;
}

.reset-btn {
  background-color: #64748b;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  display: block;
  width: 100%;
  margin-bottom: 10px;
}

.progress-bar {
  height: 8px;
  background-color: #475569;
  border-radius: 4px;
  overflow: hidden;
  margin-bottom: 5px;
}

.progress {
  height: 100%;
  background-color: #10b981;
  border-radius: 4px;
}

.progress-text {
  font-size: 12px;
  color: #94a3b8;
  margin: 0;
}

.pose-tag {
  font-size: 12px;
  background-color: #3b82f6;
  color: white;
  padding: 2px 6px;
  border-radius: 4px;
}

.pose-display {
  position: relative;
  height: 200px;
  background-color: #1e293b;
  border-radius: 4px;
  margin-bottom: 10px;
}

.placeholder-img {
  width: 100%;
  height: 100%;
  background-color: #475569;
  border-radius: 4px;
}

.status-legend {
  font-size: 12px;
  color: #94a3b8;
  display: flex;
  gap: 10px;
}

.legend-item {
  display: flex;
  align-items: center;
  gap: 4px;
}

.legend-item::before {
  content: '';
  width: 8px;
  height: 8px;
  border-radius: 50%;
  display: inline-block;
}

.green::before {
  background-color: #10b981;
}

.yellow::before {
  background-color: #f59e0b;
}

.red::before {
  background-color: #ef4444;
}

.status-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.status-list li {
  display: flex;
  justify-content: space-between;
  padding: 8px 0;
  border-bottom: 1px solid #475569;
}

.status-list li:last-child {
  border-bottom: none;
}

.status-normal {
  color: #10b981;
}

.status-stable {
  color: #10b981;
}

.score {
  color: #3b82f6;
  font-weight: bold;
}

/* 参考区域样式 */
.reference-section {
  margin-bottom: 25px;
}

.section-header {
  display: flex;
  align-items: center;
  margin-bottom: 15px;
}

.section-header h2 {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
}

.safety-tag {
  margin-left: 10px;
  background-color: #10b981;
  color: #fff;
  font-size: 12px;
  padding: 2px 8px;
  border-radius: 4px;
}

.reference-cards {
  display: flex;
  gap: 20px;
}

.reference-card {
  flex: 1;
  background-color: #1e293b;
  border-radius: 8px;
  overflow: hidden;
}

.reference-img {
  width: 100%;
  height: 160px;
  object-fit: cover;
}

.reference-card h3 {
  font-size: 16px;
  margin: 12px 15px 5px;
}

.reference-card p {
  font-size: 13px;
  color: #94a3b8;
  margin: 0 15px 15px;
}

/* 分析区域样式 */
.analysis-section {
  display: flex;
  gap: 20px;
  height: 320px;
}

.analysis-card {
  flex: 1;
  background-color: #1e293b;
  border-radius: 8px;
  padding: 15px;
  display: flex;
  flex-direction: column;
}

.analysis-header {
  display: flex;
  align-items: center;
  margin-bottom: 15px;
}

.trend-icon, .comparison-icon {
  width: 20px;
  height: 20px;
  margin-right: 8px;
  background-size: contain;
  background-repeat: no-repeat;
}

.trend-icon {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%2306b6d4'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z' /%3E%3C/svg%3E");
}

.comparison-icon {
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%233b82f6'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M8 9l3 3-3 3m5 0h3M5 21h14a2 2 0 002-2V5a2 2 0 00-2-2H5a2 2 0 00-2 2v14a2 2 0 002 2z' /%3E%3C/svg%3E");
}

.analysis-header h3 {
  margin: 0;
  font-size: 16px;
  font-weight: 500;
}

.chart-container {
  width: 100%;
  flex: 1;
  border-radius: 4px;
}
</style>