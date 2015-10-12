var module;

module = angular.module('KalturaUsageDashboard', ['angular-flot', 'tc.chartjs']);

module.controller('KalturaUsageDashboardCtrl', function($scope) {
  var borderWidth, colorAxis, colorColumn, data, mainBg;
  colorColumn = '#02a3d1';
  colorAxis = '#c2d2e1';
  mainBg = '#f0eeef';
  borderWidth = 7;
  $scope.chart = {
    data: {
      labels: ['August, 2015', 'September, 2015', 'October, 2015', 'November, 2015'],
      datasets: [
        {
          fillColor: colorColumn,
          strokeColor: colorColumn,
          data: [12, 37, 1, 75]
        }
      ]
    },
    options: {
      responsive: true,
      scaleBeginAtZero: true,
      scaleShowGridLines: false,
      scaleGridLineColor: "rgba(0,0,0,.05)",
      scaleGridLineWidth: 1,
      barShowStroke: true,
      barStrokeWidth: 2,
      barValueSpacing: 12,
      barDatasetSpacing: 1,
      legendTemplate: '<ul class="tc-chart-js-legend"><% for (var i=0; i<datasets.length; i++){%><li><span style="background-color:<%=datasets[i].fillColor%>"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>'
    }
  };
  data = [[0, 12], [1, 37], [2, 1], [3, 75]];
  return $scope.graph = {
    data: [
      {
        color: colorColumn,
        data: data
      }
    ],
    options: {
      series: {
        bars: {
          show: true,
          fill: true,
          fillColor: colorColumn
        },
        points: {
          show: true,
          radius: 3,
          lineWidth: 1
        }
      },
      tooltip: {
        show: true,
        content: function(label, x, y, flot) {
          return "<div>" + flot.series.xaxis.ticks[flot.dataIndex].label + "</div>\n<div>" + flot.series.data[flot.dataIndex][1] + "</div>";
        }
      },
      bars: {
        align: 'center',
        barWidth: 0.75
      },
      xaxis: {
        show: true,
        color: colorAxis,
        axisLabel: 'Months',
        axisLabelUseCanvas: true,
        axisLabelFontSizePixels: 12,
        axisLabelFontFamily: 'arial,sans serif',
        axisLabelPadding: 12,
        ticks: [[0, 'August, 2015'], [1, 'September, 2015'], [2, 'October, 2015'], [3, 'November, 2015']],
        tickLength: 0,
        min: -0.5,
        max: data.length - 0.5
      },
      yaxis: {
        axisLabel: 'Plays Number',
        color: colorAxis,
        axisLabelUseCanvas: true,
        axisLabelFontSizePixels: 12,
        axisLabelFontFamily: 'arial,sans serif',
        axisLabelPadding: 10,
        reserveSpace: true,
        tickLength: 10
      },
      legend: {
        noColumns: 0,
        labelBoxBorderColor: '#000000',
        position: 'nw'
      },
      grid: {
        show: true,
        hoverable: true,
        clickable: true,
        borderWidth: {
          top: 0,
          right: 0,
          bottom: borderWidth,
          left: borderWidth
        },
        borderColor: colorAxis,
        backgroundColor: mainBg,
        aboveData: false,
        axisMargin: 10
      }
    }
  };
});
