module = angular.module 'KalturaUsageDashboard', ['angular-flot']

module.controller 'KalturaUsageDashboardCtrl', ($scope) ->

	graphColumn = '#02a3d1'
	graphAxis = '#c2d2e1'
	mainBg = '#f0eeef'

	$scope.graph =
		data: [
			# label: '2012 Average Temperature'
			color: graphColumn
			data: [
				[3,	12]
				[4,	37]
				[5,	3]
			]
			# shadowSize: 2
			# highlightColor: '#bbbbbb'
		]

		options:
			series:
				bars:
					show: yes
					fill: yes
					fillColor: graphColumn
			bars:
				align: 'center'
				barWidth: 0.7
			xaxis:
				axisLabel: 'Months'
				# axisLabelUseCanvas: yes
				# axisLabelFontSizePixels: 12
				axisLabelFontFamily: 'Verdana, Arial'
				# axisLabelPadding: 10
				ticks: [
					[3,	'August, 2015']
					[4,	'September, 2015']
					[5,	'October, 2015']
				]
				tickLength: 0
			yaxis:
				axisLabel: 'Plays Number'
				# axisLabelUseCanvas: yes
				# axisLabelFontSizePixels: 12
				# axisLabelFontFamily: 'Verdana, Arial'
				# axisLabelPadding: 1
				tickFormatter: (v, axis) -> v
				# alignTicksWithAxis: 10
				tickLength: 0
			legend:
				noColumns: 0
				labelBoxBorderColor: '#000000'
				position: 'nw'
			grid:
				hoverable: yes
				clickable: yes
				borderWidth: 0
				backgroundColor: mainBg
				aboveData: yes