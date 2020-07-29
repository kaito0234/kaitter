
$(document).ready(function() {

  var select = function(start, end) { //空のイベント範囲を選択したときに実行
    var title = window.prompt("予定");
    start_time = start.unix()
    var d = new Date( start_time * 1000 );
    var year = d.getYear() + 1900;
    var month = d.getMonth() + 1;
    var day   = d.getDate();
    var hour  = ( d.getHours()   < 10 ) ? '0' + d.getHours()   : d.getHours();
    var min   = ( d.getMinutes() < 10 ) ? '0' + d.getMinutes() : d.getMinutes();
    var moment_start = year+"-"+month+"-"+day+" "+hour+":"+min;
    var start_time = moment(moment_start).add(-9, 'hour').format("YYYY-MM-DD HH:mm");
    end_time = end.unix()
    var d = new Date( end_time * 1000 );
    var year = d.getYear() + 1900;
    var month = d.getMonth() + 1;
    var day   = d.getDate();
    var hour  = ( d.getHours()   < 10 ) ? '0' + d.getHours()   : d.getHours();
    var min   = ( d.getMinutes() < 10 ) ? '0' + d.getMinutes() : d.getMinutes();
    var moment_end = year+"-"+month+"-"+day+" "+hour+":"+min;
    var end_time = moment(moment_end).add(-9, 'hour').format("YYYY-MM-DD HH:mm");
    var data = {
      event: {
        title: title,
        start: start_time,
        end: end_time,
        allDay: false
      }
    }
    $.ajax({
     type: "POST",
     url: "/users/id/events",
     data: data,
     success: function() {
       calendar.fullCalendar('refetchEvents');
     }
    });
    calendar.fullCalendar('unselect');
  };
  var calendar = $('#calendar').fullCalendar({ //カレンダー設定
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay,listMonth'
    },
    axisFormat: 'H:mm',
    timeFormat: 'H:mm',
    // timeFormat: {
    //   agenda: 'H:mm{ - H:mm}'
    // },
    monthNames: ['１月','２月','３月','４月','５月','６月','７月','８月','９月','１０月','１１月','１２月'],
    monthNamesShort: ['１月','２月','３月','４月','５月','６月','７月','８月','９月','１０月','１１月','１２月'],
    dayNames: ['日曜日','月曜日','火曜日','水曜日','木曜日','金曜日','土曜日'],
    dayNamesShort: ['日','月','火','水','木','金','土'],
    events: "/users/id/events.json",
    editable: true,        // 編集可
    selectable: true,      // 選択可
    selectHelper: true,    // 選択時にプレースホルダーを描画
    ignoreTimezone: false, // 自動選択解除
    select: select,        // 選択時に関数にパラメータ引き渡す
    buttonText: {
      prev:     '<',   // &lsaquo;
      next:     '>',   // &rsaquo;
      prevYear: '<<',  // &laquo;
      nextYear: '>>',  // &raquo;
      today:    '今日',
      listMonth:'list',
      month:    '月',
      week:     '週',
      day:      '日'
    },
    contentHeight: 'auto',
    aspectRatio: 1,             // カレンダー全体の高さ aspectRatio: 1 比率
    defaultView: 'agendaWeek',             // 初期表示ビュー
    eventLimit: true,                      // allow "more" link when too many events
    firstDay: 1,                           // 最初の曜日, 0:日曜日
    weekends: true,                        // 土曜、日曜を表示
    weekMode: 'fixed',                     // 週モード (fixed, liquid, variable)
    weekNumbers: false,                    // 週数を表示
    slotDuration: '00:30:00',              // 表示する時間軸の細かさ
    snapDuration: '00:10:00',              // スケジュールをスナップするときの動かせる細かさ
    minTime: "00:00:00",                   // スケジュールの開始時間
    maxTime: "24:00:00",                   // スケジュールの最終時間
    defaultTimedEventDuration: '00:00:00', // 画面上に表示する初めの時間(スクロールされている場所)
    allDaySlot: true,                     // 終日スロットを非表示
    // allDayDefault: true,               //終日のみ表示
    allDayText:'終日',                   // 終日スロットのタイトル
    slotMinutes: 10,                       // スロットの分
    snapMinutes: 10,                       // 選択する時間間隔
    firstHour: 9,                          // スクロール開始時間
    slotEventOverlap: true,
    eventClick: function(event) { //イベントをクリックしたときに実行
      var id = event.id
      var user_id = event.user_id
      var show_url = "/users/"+user_id+"/events/"+id
      location.href = show_url;
    },
    eventResize: function(event) { //イベントをサイズ変更した際に実行
      var id = event.id
      var user_id = event.user_id
      var update_url = "/users/"+user_id+"/events/"+id
      start_time = event.start.unix()
      var d = new Date( start_time * 1000 );
      var year = d.getYear() + 1900;
      var month = d.getMonth() + 1;
      var day   = d.getDate();
      var hour  = ( d.getHours()   < 10 ) ? '0' + d.getHours()   : d.getHours();
      var min   = ( d.getMinutes() < 10 ) ? '0' + d.getMinutes() : d.getMinutes();
      var moment_start = year+"-"+month+"-"+day+" "+hour+":"+min;
      var start_time = moment(moment_start).add(-9, 'hour').format("YYYY-MM-DD HH:mm");
      end_time = event.end.unix()
      var d = new Date( end_time * 1000 );
      var year = d.getYear() + 1900;
      var month = d.getMonth() + 1;
      var day   = d.getDate();
      var hour  = ( d.getHours()   < 10 ) ? '0' + d.getHours()   : d.getHours();
      var min   = ( d.getMinutes() < 10 ) ? '0' + d.getMinutes() : d.getMinutes();
      var moment_end = year+"-"+month+"-"+day+" "+hour+":"+min;
      var end_time = moment(moment_end).add(-9, 'hour').format("YYYY-MM-DD HH:mm");
      var data = {_method: 'PUT',
        event: {
          title: event.title,
          start: start_time,
          end: end_time,
          allDay: false
        }
      }
      $.ajax({
       type: "POST",
       url: update_url,
       data: data,
       success: function() {
         calendar.fullCalendar('refetchEvents');
       }
      });
      calendar.fullCalendar('unselect');
    },
    // dayClick: function(date, allDay) {

    //   var title = prompt('予定を入力してください:');
      
    //   $('#calendar').fullCalendar('addEventSource', [{
    //   title: title,
    //   start: date,
    //   allDay: allDay
    //   }]);
      
    //   },
    eventDrop: function(event) { //イベントをドラッグ&ドロップした際に実行
      var id = event.id
      var user_id = event.user_id
      var update_url = "/users/"+user_id+"/events/"+id
      start_time = event.start.unix()
      var d = new Date( start_time * 1000 );
      var year = d.getYear() + 1900;
      var month = d.getMonth() + 1;
      var day   = d.getDate();
      var hour  = ( d.getHours()   < 10 ) ? '0' + d.getHours()   : d.getHours();
      var min   = ( d.getMinutes() < 10 ) ? '0' + d.getMinutes() : d.getMinutes();
      var moment_start = year+"-"+month+"-"+day+" "+hour+":"+min;
      var start_time = moment(moment_start).add(-9, 'hour').format("YYYY-MM-DD HH:mm");
      end_time = event.end.unix()
      var d = new Date( end_time * 1000 );
      var year = d.getYear() + 1900;
      var month = d.getMonth() + 1;
      var day   = d.getDate();
      var hour  = ( d.getHours()   < 10 ) ? '0' + d.getHours()   : d.getHours();
      var min   = ( d.getMinutes() < 10 ) ? '0' + d.getMinutes() : d.getMinutes();
      var moment_end = year+"-"+month+"-"+day+" "+hour+":"+min;
      var end_time = moment(moment_end).add(-9, 'hour').format("YYYY-MM-DD HH:mm");
      var data = {_method: 'PUT',
        event: {
          title: event.title,
          start: start_time,
          end: end_time,
          allDay: false
        }
      }
      $.ajax({
       type: "POST",
       url: update_url,
       data: data,
       success: function() {
         calendar.fullCalendar('refetchEvents');
       }
      });
      calendar.fullCalendar('unselect');
    }
  });
});