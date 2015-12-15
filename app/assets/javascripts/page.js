// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var chart;

function crypt(type) {
  $.ajax({
    url: 'http://localhost:3000/crypt',
    type: 'GET',
    data: {
      text: $('#input-ta').val(),
      offset: $('#offset').val(),
      type: type
    },
    success: function(data) {
      $('#result-ta').val(data['text']);
    },
    error: function(e) {
      $('#info').html('<p>An error has occurred</p>').addClass("info-error");
    },
    dataType: 'json'
  });
}

function setChart() {
  var chartOptions = {
    chart: {
      renderTo: 'chart',
      type: 'column'
    },
    title: {
      text: 'Letter frequency'
    },
    xAxis: {
      categories: [],
      crosshair: true
    },
    yAxis: {
      min: 0,
      title: {
          text: 'Frequency'
      }
    },
    plotOptions: {
      column: {
        pointPadding: 0.2,
        borderWidth: 0
      }
    },
    series: [{
      name: 'Letters',
      data: []
    }]
  };

  chart = new Highcharts.Chart(chartOptions);
};

function analyseText() {
  $.ajax({
    url: 'http://localhost:3000/analyse_text',
    type: 'GET',
    data: {
      text: $('#input-ta').val()
    },
    success: function(data) {
      $('#result-ta').val(data['text']);
      $('#info').html('<p>Guessed offsets: '+data['guessed_offsets']+'</p>').addClass("info-success");

      letter_freq = data['letter_freq'];
      letters = Object.keys(letter_freq);
      values = Object.keys(letter_freq).map(function (key) {
       return letter_freq[key];
      });
      
      chart.series[0].setData(values);
      chart.xAxis[0].setCategories(letters);
      $('#chart').show();
    },
    error: function(e) {
      $('#info').html('<p>An error has occurred</p>').addClass("info-error");
    },
 dataType: 'json'
  });
};

var delay = (function(){
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();

$(function(){

  $("#input-ta" ).focus();
  $("#result-ta" ).prop( "disabled", true );

  $('#encrypt-btn').click(function() {
    crypt('encrypt')
  });

  $('#decrypt-btn').click(function() {
    crypt('decrypt')
  });

  $('#input-ta').on('input', function() {
    delay(function(){
      analyseText()
    }, 1000);
  });

  setChart();

  $('#chart').hide();

});
