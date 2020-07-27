// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require jquery-ui
//= require turbolinks
//= require moment
//= require fullcalendar
//= require_tree .

// $(document).ready(function() {
//   var select = function(start, end, allDay) {
//       var title = window.prompt("title");
//       var start = moment(event.start).format('Y-MM-DD HH:mm:ss');
//       var end = moment(event.end).format('Y-MM-DD HH:mm:ss');
//       var data = {event: {title: title,
//                           start: start,
//                           end: end, 
//                           allDay: allDay}};
//       $.ajax({
//           type: "POST",
//           url: "/users/id/events",
//           data: data,
//           success: function() {
//               calendar.fullCalendar('refetchEvents');
//           }
//       });
//       calendar.fullCalendar('unselect');
//   };

//   var calendar = $('#calendar').fullCalendar({
//       events: '/users/id/events.json',
//       selectable: true,
//       selectHelper: true,
//       ignoreTimezone: false,
//       select: select
//   });
// });







// $(function () {
//   // 画面遷移を検知
//   $(document).on('turbolinks:load', function () {
//       if ($('#calendar').length) {

//           function Calendar() {
//               return $('#calendar').fullCalendar({
//               });
//           }

//            // *** ここから以下、追加 *** 

//             // creat_event
//             create_event = function(title, start, end){
//               // CSRF Token
//               $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
//                   var token;
//                   if (!options.crossDomain) {
//                       token = $('meta[name="csrf-token"]').attr('content');
//                       if (token) {
//                           return jqXHR.setRequestHeader('X-CSRF-Token', token);
//                       }
//                   }
//               });
//               // ajax : 追加時
//               $.ajax({
//                   type: "post",
//                   url: "/events",
//                   data: JSON.stringify({
//                       title: title,
//                       start_date: start.toISOString(),
//                       end_date: end.toISOString()
//                   }),
//                   contentType: 'application/JSON'
//               }).done(function(data){
//                   alert("登録しました!");
//               }).fail(function(data){
//                   alert("登録できませんでした。");
//               });
//           };

//           // *** ここまで *** 
//           function clearCalendar() {
//               $('#calendar').html('');
//           }

//            // *** ここから以下、追加 *** 

//                 // カレンダーへの追加でイベント保存
//                 navLinks: true,
//                 selectable: true,
//                 selectHelper: true,

//                 // event が 作成 されたときに create_event を実行して、ajax を飛ばす
//                 select: function(start, end) {
//                     var title = prompt('イベントを追加');
//                     var eventData;
//                     if (title) {
//                         eventData = {
//                             title: title,
//                             start: start,
//                             end: end
//                         };
//                         $('#calendar').fullCalendar('renderEvent', eventData, true);
//                         $('#calendar').fullCalendar('unselect');
//                         create_event(title, start, end);
//                     }
//                 },

//                 // *** ここまで *** 

//           $(document).on('turbolinks:load', function () {
//               Calendar();
//           });
//           $(document).on('turbolinks:before-cache', clearCalendar);

//           //events: '/events.json', 以下に追加
//           $('#calendar').fullCalendar({
//               events: '/events.json',
//               //カレンダー上部を年月で表示させる
//               titleFormat: 'YYYY年 M月',
//               //曜日を日本語表示
//               dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
//               //ボタンのレイアウト
//               header: {
//                   left: '',
//                   center: 'title',
//                   right: 'today prev,next'
//               },
//               //終了時刻がないイベントの表示間隔
//               defaultTimedEventDuration: '03:00:00',
//               buttonText: {
//                   prev: '前',
//                   next: '次',
//                   prevYear: '前年',
//                   nextYear: '翌年',
//                   today: '今日',
//                   month: '月',
//                   week: '週',
//                   day: '日'
//               },
//               // Drag & Drop & Resize
//               editable: true,
//               //イベントの時間表示を２４時間に
//               timeFormat: "HH:mm",
//               //イベントの色を変える
//               eventColor: '#87cefa',
//               //イベントの文字色を変える
//               eventTextColor: '#000000',
//               eventRender: function(event, element) {
//                   element.css("font-size", "0.8em");
//                   element.css("padding", "5px");
//               }
//           });
//       }
//   });
// });




// $(function () {
//   function eventCalendar() {
//       return $('#calendar').fullCalendar({});
//   };
//   function clearCalendar() {
//       $('#calendar').html('');
//   };
//   $(document).on('turbolinks:load', function () {
//   eventCalendar();
//   });
//   $(document).on('turbolinks:before-cache', clearCalendar);

//   $('#calendar').fullCalendar({
//   events: '/users/events.json'
//   });
// });

// $(document).ready(function() {
//   var prepare = function(options, originalOptions, jqXHR) {
//     var token;
//     if (!options.crossDomain) {
//       token = $('meta[name="csrf-token"]').attr('content');
//       if (token) {
//         return jqXHR.setRequestHeader('X-CSRF-Token', token);
//       }
//     }
//   };
//   }
//   )

//   // カレンダー表示
//   $('#calendar').fullCalendar ({
//       header: {
//           left: 'prev,next today',
//           center: 'month,agendaWeek,agendaDay',
//           right: 'title'
//       },

//       buttonText: {
//             prev: "<",
//             next: ">"
//       },

//       timezone: 'UTC',
//       events: '/users/events.json',
//       navLinks: true,
//       selectable: true,
//       selectHelper: true,
//       // 日付クリック
//       dayClick : function ( date , jsEvent , view ) {
//           $('#inputScheduleForm').modal('show');
//           },

//       // event クリックで編集、削除
//       eventClick : function(event, jsEvent , view) {
//           jsEvent.preventDefault();
//           $(`#inputScheduleEditForm${event.id}`).modal('show');
//       },

//       eventMouseover : function(event, jsEvent , view) {
//           jsEvent.preventDefault();
//       }
//   })

// $(document).ready(function () {

//   // 外部イベントを初期化します
//   // -----------------------------------------------------------------
//   $('#external-events .fc-event').each(function() {
//       // カレンダーがドロップ時にイベントをレンダリングできるようにデータを保存します
//       $(this).data('event', {
//           title: $.trim($(this).text()), // イベントタイトルとして要素のテキストを使用
//           stick: true //ユーザがナビゲートする時に維持する(renderEventメソッドのドキュメントを参照)
//       });

//       // jQuery UIを使用してイベントをドラッグ可能にします
//       $(this).draggable({
//           zIndex: 999,
//           revert: true,      // イベントをもとの状態に戻します
//           revertDuration: 0  // ドラッグ後の元の位置
//       });
//   });

//   // カレンダーの設定
//   $('#calendar').fullCalendar({
//       header: {
//           left: 'prev,next today',
//           center: 'title',
//           right: 'month,agendaWeek,agendaDay'
//       },
//       height: 550,
//       lang: "ja",
//       selectable: true,
//       selectHelper: true,
//       select: function(start, end) {
//           var title = prompt("予定タイトル:");
//           var eventData;
//           if (title) {
//               eventData = {
//                       title: title,
//                       start: start,
//                       end: end
//               };
//               $('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
//           }
//           $('#calendar').fullCalendar('unselect');
//       },
//       droppable: true, // これにより、モノをカレンダーにドロップできます
//       drop: function(date, jsEvent, ui, resourceId) {
//         var params = new Object();
//         var date = moment(date);
//         params['title'] = this.innerText;
//         params['start_date'] = date.format('YYYY-MM-DD HH:mm:ss');
//         params['end_date'] = date.add(2, "hour").format('YYYY-MM-DD HH:mm:ss');
    
//         $.ajax({
//             type: "POST",
//             url: "/dev/ajax",
//             data: params
//         })
//     },
//       editable: true,
//       eventLimit: true, 
//   });
// });