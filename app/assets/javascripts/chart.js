// window.draw_graph = function() {
//   var ctx, myChart;
//   ctx = document.getElementById("myChart").getContext('2d');
//   return myChart = new Chart(ctx, {
//     type: 'bar',
//     data: {
//       datasets: [
//         {
//           label: '# of Votes',
//           data: gon.bardata,
//           backgroundColor: 'rgba(75, 192, 192, 0.2)',
//           borderColor: 'rgba(75, 192, 192, 1)',
//           borderWidth: 1
//         }, {
//           label: 'Line Dataset',
//           data: gon.linedata,
//           type: 'line'
//         }
//       ],
//       labels: gon.timedata
//     },
//     options: {
//       scales: {
//         // xAxes: [{
//         //   type: 'time',
//         //   distribution: 'linear',
//         //   ticks: {
//         //     'data': 'data'
//         //   }
//         // }],
//         yAxes: [
//           {
//             ticks: {
//               beginAtZero: true,
//               max: 100
//             }
//           }
//         ]
//       }
//     }
//   });
// };