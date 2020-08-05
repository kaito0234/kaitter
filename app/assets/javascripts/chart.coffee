# window.draw_graph = -> 
#     ctx = document.getElementById("myChart").getContext('2d')
#     barNum = 7
#     labels = new Array(barNum)
#     bgColors = new Array(barNum)
#     bdColors = new Array(barNum)
#     for i in [0...barNum]
#         labels[i] = '7-' + i
#         bgColors[i] = 'rgba(75, 192, 192, 0.2)'
#         bdColors[i] = 'rgba(75, 192, 192, 1)'
#     myChart = new Chart(ctx, {
#         type: 'bar',
#         data: {
#             datasets: [{
#                 label: '# of Votes',
#                 data: gon.bardata,
#                 backgroundColor: bgColors,
#                 borderColor: bdColors,
#                 borderWidth: 1
#             }, {
#                 label: 'Line Dataset',
#                 data: gon.linedata,
#                 type: 'line'
#             }],
#             labels: labels,
#         },
#         options: {
#             scales: {
#                 yAxes: [{
#                     ticks: {
#                         beginAtZero:true
#                     }
#                 }]
#             }
#         }
#     })


window.draw_graph = -> 
    ctx = document.getElementById("myChart").getContext('2d')
    myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            datasets: [{
                label: '# of Votes',
                data: gon.bardata,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }, {
                label: 'Line Dataset',
                data: gon.linedata,
                type: 'line'
            }],
            labels: gon.timedata,
        },
        options: {
            scales: {
                xAxes: {
                    type: 'time',
                    distribution: 'linear'
                    ticks: {
                        'data'
                    }
                },
                yAxes: [{
                    ticks: {
                        beginAtZero:true,
                        max: 100
                    }
                }]
            }
        }
    })



# window.draw_graph = -> 
#   ctx = document.getElementById("conditionsChart").getContext('2d')
#   conditionsChart = new Chart(ctx, {
#       type: 'bar',
#       data: {
#           labels: gon.graphdays,#ここは日付が表示される　X軸に当たる
#           datasets: [{
#               label: '運動時間',
#               data: gon.graphtimes,#ここは時間が表示される　Y軸に当たる
#               backgroundColor: [
#                   'rgba(255, 159, 64, 0.2)',
#                   'rgba(255, 159, 64, 0.2)',
#                   'rgba(255, 159, 64, 0.2)',
#                   'rgba(255, 159, 64, 0.2)',
#                   'rgba(255, 159, 64, 0.2)',
#                   'rgba(255, 159, 64, 0.2)'
#               ],
#               borderColor: [
#                   'rgba(255, 159, 64, 1)',
#                   'rgba(255, 159, 64, 1)',
#                   'rgba(255, 159, 64, 1)',
#                   'rgba(255, 159, 64, 1)',
#                   'rgba(255, 159, 64, 1)',
#                   'rgba(255, 159, 64, 1)'
#               ],
#               borderWidth: 1
#           }]
#       },
#       options: {
#           scales: {
#               yAxes: [{
#                   ticks: {
#                       beginAtZero:true
#                   }
#               }]
#           }
#       }
#   })