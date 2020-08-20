$(document).ready(function() {

  var select = function(startDate, endDate) { //空のイベント範囲を選択したときに実行
    var title = window.prompt("予定");
    var params_user_url = "/users/"+gon.params_user_id+"/events.json"
    var allDay = !endDate.hasTime() && !endDate.hasTime();
    var data = {
      event: {
        title: title,
        start: startDate.format(),
        end: endDate.format(),
        allDay: allDay
      }
    }
    $.ajax({
     type: "POST",
     url: params_user_url,
     data: data,
     dataType: 'json',
     success: function() {
       calendar.fullCalendar('refetchEvents');
     }
    });
    calendar.fullCalendar('unselect');
  };

  // Documentの読み込みが完了するまで待機し、カレンダーを初期化
  var params_user_url = "/users/"+gon.params_user_id+"/events.json"
  var calendar = $('#calendar').fullCalendar({
    // ヘッダーのタイトルとボタン
    header: {
      // title, prev, next, prevYear, nextYear, today
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay listMonth'
    },
    buttonText: {
      prev:     '<',   // &lsaquo;
      next:     '>',   // &rsaquo;
      prevYear: '<<',  // &laquo;
      nextYear: '>>',  // &raquo;
      today:    '今日',
      listMonth:'M',
      month:    '月',
      week:     '週',
      day:      '日'
    },
    
    // theme: false,  // jQuery UI theme

    slotLabelFormat: 'H:mm',
    timeFormat: 'H:mm',
    views: {
      month: {
        titleFormat: 'YYYY年 M月',
        columnHeaderFormat:'ddd'
      },
      week: {
        titleFormat: 'M月D日',
        // columnHeaderFormat:'D ddd'
      },
      day: {
        titleFormat: 'M月D日',
        // columnHeaderFormat:'D日 ddd'
      }
    },
    listDayFormat: 'M月D日',
    listDayAltFormat: 'dddd',
    listWeekFormat: 'M月D日',
    listWeekltFormat: 'dddd',
    listMonthFormat: 'M月D日',
    listMonthAltFormat: 'dddd',

    monthNames: ['１月','２月','３月','４月','５月','６月','７月','８月','９月','１０月','１１月','１２月'],
    monthNamesShort: ['１月','２月','３月','４月','５月','６月','７月','８月','９月','１０月','１１月','１２月'],
    dayNames: ['日曜日','月曜日','火曜日','水曜日','木曜日','金曜日','土曜日'],
    dayNamesShort: ['日','月','火','水','木','金','土'],

    events: params_user_url,
    editable: true,        // 編集可
    selectable: true,      // 選択可
    selectHelper: true,    // 選択時にプレースホルダーを描画
    ignoreTimezone: false, // 自動選択解除
    selectMinDistance: 1,
    select: select,        // 選択時に関数にパラメータ引き渡す
    
    height: 550,                         // 高さ(px)
    // contentHeight: 'auto',                 // コンテンツの高さ(px,auto)
    aspectRatio: 1.8,                      // カレンダー全体の高さ aspectRatio: 1 比率
    defaultView: 'agendaWeek',             // 初期表示ビュー
    eventLimit: false,                     // allow "more" link when too many events
    firstDay: 1,                           // 最初の曜日, 0:日曜日
    weekends: true,                        // 土曜、日曜を表示
    weekMode: 'fixed',                     // 週モード (fixed, liquid, variable)
    weekNumbers: false,                    // 週数を表示
    slotDuration: '00:30:00',              // 表示する時間軸の細かさ
    snapDuration: '00:10:00',              // スケジュールをスナップするときの動かせる細かさ
    minTime: "00:00:00",                   // スケジュールの開始時間
    maxTime: "24:00:00",                   // スケジュールの最終時間
    defaultTimedEventDuration: '00:00:00', // 画面上に表示する初めの時間(スクロールされている場所)
    allDaySlot: true,                      //  終日スロットを非表示
    // allDayDefault: true,                // 終日のみ表示
    allDayText:'終日',                     // 終日スロットのタイトル
    slotMinutes: 10,                       // スロットの分
    snapMinutes: 10,                       // 選択する時間間隔
    firstHour: 9,                          // スクロール開始時間
    slotEventOverlap: true,                // イベントを重ねる
    forceEventDuration: true,

    //  ビュー表示イベント
    // viewDisplay: function (view) {
    //   alert('ビュー表示イベント ' + view.title);
    // },
    // ウィンドウリサイズイベント
    // windowResize: function (view) {
    //   alert('ウィンドウリサイズイベント');
    // },
    //  日付クリックイベント
    // dayClick: function () {
    //   alert('日付クリックイベント');
    // },

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

      var data = {_method: 'PUT',
        event: {
          title: event.title,
          end: event.end.format(),
        }
      }

      $.ajax({
       type: "POST",
       url: update_url,
       data: data,
       dataType: 'json',
       success: function() {
         calendar.fullCalendar('refetchEvents');
       }
      });
      calendar.fullCalendar('unselect');
    },

    eventDrop: function(event) { //イベントをドラッグ&ドロップした際に実行
      var id = event.id
      var user_id = event.user_id
      var update_url = "/users/"+user_id+"/events/"+id

      var allDay = !event.end.hasTime();
      var data = {_method: 'PUT',
        event: {
          title: event.title,
          start: event.start.format(),
          end: event.end.format(),
          allDay: allDay,
        }
      }

      $.ajax({
       type: "POST",
       url: update_url,
       data: data,
       dataType: 'json',
       success: function() {
         calendar.fullCalendar('refetchEvents');
       }
      });
      calendar.fullCalendar('unselect');
    }
  });
  // 動的にオプションを変更
  //$('#calendar').fullCalendar('option', 'height', 700);

  // カレンダーをレンダリング。表示切替時などに使用
  //$('#calendar').fullCalendar('render');

  // カレンダーを破棄（イベントハンドラや内部データも破棄）
  //$('#calendar').fullCalendar('destroy')
});