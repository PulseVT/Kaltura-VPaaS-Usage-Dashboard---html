var module;

module = angular.module('KalturaUsageDashboard', ['angular-flot']);

module.controller('KalturaUsageDashboardCtrl', function($scope) {
  var graphAxis, graphColumn, mainBg;
  graphColumn = '#02a3d1';
  graphAxis = '#c2d2e1';
  mainBg = '#f0eeef';
  return $scope.graph = {
    data: [
      {
        color: graphColumn,
        data: [[3, 12], [4, 37], [5, 3]]
      }
    ],
    options: {
      series: {
        bars: {
          show: true,
          fill: true,
          fillColor: graphColumn
        }
      },
      bars: {
        align: 'center',
        barWidth: 0.7
      },
      xaxis: {
        axisLabel: 'Months',
        axisLabelFontFamily: 'Verdana, Arial',
        ticks: [[3, 'August, 2015'], [4, 'September, 2015'], [5, 'October, 2015']],
        tickLength: 0
      },
      yaxis: {
        axisLabel: 'Plays Number',
        tickFormatter: function(v, axis) {
          return v;
        },
        tickLength: 0
      },
      legend: {
        noColumns: 0,
        labelBoxBorderColor: '#000000',
        position: 'nw'
      },
      grid: {
        hoverable: true,
        clickable: true,
        borderWidth: 0,
        backgroundColor: mainBg,
        aboveData: true
      }
    }
  };
});
