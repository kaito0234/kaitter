const condutionData = {
  level: gon.bardata,
  date: gon.timedata,
};

const loadCharts = function () {
  const chartDataSet = {
    type: 'line',
    data: {
      datasets: [{
        label: 'line',
        data: [],
        type: 'line'
      }, {
        label: 'bar',
        data: [],
        backgroundColor: 'rgba(75, 192, 192, 0.2)',
        borderColor: 'rgba(75, 192, 192, 1)',
        borderWidth: 1
      }]
    },
    options: {
      maintainAspectRatio: false,
      tooltips: {
        enabled: true,
        mode: 'single',
        callbacks: {
          afterLabel: function(tooltipItem, data) { 
            return gon.memo[tooltipItem.index];
          }
        }
      },
      scales: {
        xAxes: [{
          type: 'time',
          distribution: 'linear',
          ticks: {
            source: 'data'
          }
          // time: {
          //   unit: 'hour',
          //   fomat: 'H'
          // }
        }],
        yAxes: [{
          ticks: {
            beginAtZero: true,
            max: 100
          }
        }]
      }
    }
  };
  for (let i = 0; i < condutionData.level.length; i++) {
    chartDataSet.data.datasets[0].data.push({
      y: condutionData.level[i],
      x: new Date(condutionData.date[i])
    });
  }
  
  const ctx = document.createElement('canvas');
  document.getElementById('chart-area').appendChild(ctx);
  new Chart(ctx, chartDataSet);
};

loadCharts();



    
