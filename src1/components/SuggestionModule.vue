<template>
  <div class="right-content">
    <!-- 顶部操作栏 -->
    <div class="top-bar">
      <h2>行业对比分析</h2>
      <p>基于真实数据的焊接行业深度分析</p>
      <div class="action-buttons">
        <button>导出报告</button>
        <button>分享</button>
      </div>
    </div>

    <!-- 标签栏 -->
    <div class="tab-bar">
      <button class="active">市场分析</button>
      <button>安全分析</button>
      <button>技术分析</button>
      <button>对比分析</button>
      <button>实训数据</button>
    </div>

    <!-- 数据卡片区域 -->
    <div class="card-group">
      <div class="data-card">
        <p>全球工业焊材市场</p>
        <p class="value">¥215.5B</p>
        <p>2024年市场价值</p>
      </div>
      <div class="data-card">
        <p>全球增长率</p>
        <p class="value">4.9%</p>
        <p>2025-2034年CAGR</p>
      </div>
      <div class="data-card">
        <p>中国市场规模</p>
        <p class="value">¥404.5B</p>
        <p>2024年总营收</p>
      </div>
      <div class="data-card">
        <p>焊接材料增长</p>
        <p class="value">13.7%</p>
        <p>2017-2022年CAGR</p>
      </div>
    </div>

    <!-- 市场规模分布图表 -->
    <div class="chart-container">
      <div id="marketScaleChart" style="width: 100%; height: 300px;"></div>
    </div>

    <!-- 中国主要省份市场分布图表 -->
    <div class="chart-container">
      <div id="provinceMarketChart" style="width: 100%; height: 300px;"></div>
    </div>

    <!-- 行业发展趋势 -->
    <div class="trend-section">
      <h3>行业发展趋势</h3>
      <div class="trend-item">
        <div class="trend-header">
          <h4>环保化转型</h4>
          <span>2024-2030</span>
        </div>
        <p>水性涂料、粉末涂料等环保产品需求增长</p>
        <div class="score-bar">
          <div class="bar" style="width: 92%"></div>
          <span>9.2/10</span>
        </div>
      </div>
      <div class="trend-item">
        <div class="trend-header">
          <h4>智能化升级</h4>
          <span>2024-2028</span>
        </div>
        <p>自动化喷涂设备和机器人应用普及</p>
        <div class="score-bar">
          <div class="bar" style="width: 88%"></div>
          <span>8.8/10</span>
        </div>
      </div>
      <div class="trend-item">
        <div class="trend-header">
          <h4>定制化需求</h4>
          <span>2025-2032</span>
        </div>
        <p>个性化涂装解决方案需求增加</p>
        <div class="score-bar">
          <div class="bar" style="width: 75%"></div>
          <span>7.5/10</span>
        </div>
      </div>
      <div class="trend-item">
        <div class="trend-header">
          <h4>数字化管理</h4>
          <span>2024-2027</span>
        </div>
        <p>涂装过程数字化监控和质量管理</p>
        <div class="score-bar">
          <div class="bar" style="width: 81%"></div>
          <span>8.1/10</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import * as echarts from 'echarts';

export default {
  mounted() {
    // 初始化市场规模分布图表
    this.initMarketScaleChart();
    // 初始化中国主要省份市场分布图表
    this.initProvinceMarketChart();
  },
  methods: {
    initMarketScaleChart() {
      const chartDom = document.getElementById('marketScaleChart');
      const myChart = echarts.init(chartDom);
      const option = {
        tooltip: {
          trigger: 'item',
          formatter: '{b}<br/>value: {c}',
        },
        xAxis: {
          type: 'category',
          data: ['全球工业焊材', '中国焊接设备', '中国焊接材料', '中国焊接总营收'],
          axisLabel: {
            color: '#333',
          },
        },
        yAxis: {
          type: 'value',
          max: 600,
          axisLabel: {
            color: '#333',
          },
        },
        series: [
          {
            data: [200, 150, 50, 400],
            type: 'bar',
            itemStyle: {
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: '#6a5acd' },
                { offset: 1, color: '#9370db' },
              ]),
            },
            emphasis: {
              itemStyle: {
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                  { offset: 0, color: '#483d8b' },
                  { offset: 1, color: '#6a5acd' },
                ]),
              },
            },
          },
        ],
        grid: {
          left: '3%',
          right: '3%',
          bottom: '3%',
          top: '10%',
          containLabel: true,
        },
      };
      myChart.setOption(option);
    },
    initProvinceMarketChart() {
      const chartDom = document.getElementById('provinceMarketChart');
      const myChart = echarts.init(chartDom);
      const option = {
        tooltip: {
          trigger: 'item',
          formatter: '{b}<br/>{c}',
        },
        xAxis: {
          type: 'category',
          data: ['广东', '江苏', '浙江', '山东', '上海'],
          axisLabel: {
            color: '#333',
          },
        },
        yAxis: {
          type: 'value',
          max: 20,
          axisLabel: {
            color: '#333',
          },
        },
        series: [
          {
            data: [19, 15, 13, 11, 8],
            type: 'bar',
            itemStyle: {
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: '#66cdaa' },
                { offset: 1, color: '#8fbc8f' },
              ]),
            },
            emphasis: {
              itemStyle: {
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                  { offset: 0, color: '#48d1cc' },
                  { offset: 1, color: '#66cdaa' },
                ]),
              },
            },
          },
        ],
        grid: {
          left: '3%',
          right: '3%',
          bottom: '3%',
          top: '10%',
          containLabel: true,
        },
      };
      myChart.setOption(option);
    },
  },
};
</script>

<style scoped>
.right-content {
  flex: 1;
  padding: 20px;
  color: #333;
}

.top-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.top-bar h2 {
  font-size: 24px;
  color: #fff;
}

.top-bar p {
  color: #ccc;
  margin-top: 5px;
}

.action-buttons {
  display: flex;
  gap: 10px;
}

.action-buttons button {
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  background-color: #fff;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 5px;
}

.tab-bar {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
  border-bottom: 1px solid #ddd;
  padding-bottom: 10px;
}

.tab-bar button {
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  background-color: #f0f0f0;
  cursor: pointer;
}

.tab-bar button.active {
  background-color: #0a1931;
  color: #fff;
}

.card-group {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
  margin-bottom: 20px;
}

.data-card {
  background-color: #fff;
  border-radius: 8px;
  padding: 15px;
  text-align: center;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.data-card .value {
  font-size: 20px;
  font-weight: bold;
  margin: 10px 0;
}

.data-card p:nth-child(2) {
  color: #6a5acd;
}
.data-card:nth-child(2) .value {
  color: #228b22;
}
.data-card:nth-child(3) .value {
  color: #9932cc;
}
.data-card:nth-child(4) .value {
  color: #ff6347;
}

.chart-container {
  background-color: #fff;
  border-radius: 8px;
  padding: 20px;
  margin-bottom: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.trend-section {
  background-color: #fff;
  border-radius: 8px;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.trend-section h3 {
  margin-bottom: 20px;
  font-size: 18px;
}

.trend-item {
  margin-bottom: 15px;
  padding-bottom: 15px;
  border-bottom: 1px solid #eee;
}

.trend-item:last-child {
  border-bottom: none;
}

.trend-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

.trend-header h4 {
  font-size: 16px;
}

.trend-header span {
  font-size: 12px;
  color: #999;
}

.trend-item p {
  font-size: 14px;
  color: #666;
  margin-bottom: 8px;
}

.score-bar {
  height: 6px;
  background-color: #eee;
  border-radius: 3px;
  overflow: hidden;
  position: relative;
}

.score-bar .bar {
  height: 100%;
  background-color: #4169e1;
}

.score-bar span {
  position: absolute;
  right: 0;
  top: -20px;
  font-size: 12px;
  color: #999;
}
</style>