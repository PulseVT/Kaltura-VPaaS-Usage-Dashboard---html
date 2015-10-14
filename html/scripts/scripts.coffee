module = angular.module 'KalturaUsageDashboard', [
	'angular-flot'
	'rt.select2'
	'ui.date'
	'ui.bootstrap'
	'ui.router'
]

module.config ($stateProvider, $urlRouterProvider, $locationProvider) ->
	$urlRouterProvider.otherwise '/overall-usage'
	$locationProvider.html5Mode yes

	$stateProvider
	.state('overall-usage',
		url: '/overall-usage'
		views:
			main:
				templateUrl: 'html/html-source/pages/overall-usage-report.html'
	)
	.state('plays',
		url: '/plays'
		views:
			main:
				templateUrl: 'html/html-source/pages/plays-report.html'
	)
	.state('bandwidth',
		url: '/bandwidth'
		views:
			main:
				templateUrl: 'html/html-source/pages/bandwidth-report.html'
	)
	.state('storage',
		url: '/storage'
		views:
			main:
				templateUrl: 'html/html-source/pages/storage-report.html'
	)
	.state('transcoding-consumption',
		url: '/transcoding-consumption'
		views:
			main:
				templateUrl: 'html/html-source/pages/transcoding-consumption-report.html'
	)
	.state('media-entries',
		url: '/media-entries'
		views:
			main:
				templateUrl: 'html/html-source/pages/media-entries-report.html'
	)

module.directive 'kalturaDatepicker', ->
	restrict: 'A'
	replace: yes
	template: """
		<span class='datepicker'>
			<input ui-date='datepickerOptions' name='name' ng-model='model'/>
			<span class='icon' ng-click='open()'>
				<i class='fa fa-calendar'></i>
			</span>
		</span>
		"""
	controller: ($scope, $element) ->
		$scope.options =
			changeYear: yes
			changeMonth: yes
			yearRange: '2000:-0'
		$scope.name = 'datepicker' unless $scope.name
		$scope.model = new Date unless $scope.model
		$scope.open = ->
			$element.find('input').datepicker 'show'
			null
		$scope.hide = ->
			$element.find('input').datepicker 'hide'
			null
	scope:
		model: '=datepicker'
		name: '=?'

module.controller 'KalturaUsageDashboardCtrl', ($scope, $state) ->

	$scope.state = $state

	#select
	$scope.select =
		data: [
			id: 0
			name: 'Last month'
		,
			id: 1
			name: 'Last 3 months'
		,
			id: 2
			name: 'Custom date range by month'
		]
		options:
			allowClear: no
			placeholder: 'Select period...'
			minimumResultsForSearch: -1
		model: 2

	#constants for graph
	colorColumn = '#02a3d1'
	colorAxis = '#c2d2e1'
	mainBg = '#f0eeef'
	borderWidth = 7

	#CHART.JS

	$scope.chart =
		data:
			labels: ['August, 2015', 'September, 2015', 'October, 2015', 'November, 2015']
			datasets: [
				# label: 'Plays'
				fillColor: colorColumn
				strokeColor: colorColumn
				data: [12, 37, 1, 75]
			]

		options:
			responsive: yes
			# Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
			scaleBeginAtZero : yes

			#Boolean - Whether grid lines are shown across the chart
			scaleShowGridLines : no

			#String - Colour of the grid lines
			scaleGridLineColor : "rgba(0,0,0,.05)"

			#Number - Width of the grid lines
			scaleGridLineWidth : 1

			#Boolean - If there is a stroke on each bar
			barShowStroke : yes

			#Number - Pixel width of the bar stroke
			barStrokeWidth : 2

			#Number - Spacing between each of the X value sets
			barValueSpacing : 12

			#Number - Spacing between data sets within X values
			barDatasetSpacing : 1

			#String - A legend template
			legendTemplate : '<ul class="tc-chart-js-legend"><% for (var i=0; i<datasets.length; i++){%><li><span style="background-color:<%=datasets[i].fillColor%>"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>'
	

	#FLOT

	data = [
		[0,	12]
		[1,	37]
		[2,	1]
		[3,	75]
	]

	$scope.graph =
		data: [
			# label: '2012 Average Temperature'
			color: colorColumn
			data: data
			# shadowSize: 2
			# highlightColor: '#bbbbbb'
		]

		options:
			series:
				bars:
					show: yes
					fill: yes
					fillColor: colorColumn
				# points:
				# 	show: yes
				# 	radius: 3
				# 	lineWidth: 1
			tooltip:
				show: yes
				content: (label, x, y, flot) ->
					"""
						<div class='text'>#{flot.series.xaxis.ticks[flot.dataIndex].label}</div>
						<div class='value'>#{flot.series.data[flot.dataIndex][1]}</div>
					"""
				cssClass: 'graph-tooltip'
			bars:
				align: 'center'
				barWidth: 0.75
			xaxis:
				show: yes
				color: colorAxis
				axisLabel: 'Months'
				axisLabelUseCanvas: yes
				axisLabelFontSizePixels: 12
				axisLabelFontFamily: 'arial,sans serif'
				axisLabelPadding: 12
				ticks: [
					[0,	'August, 2015']
					[1,	'September, 2015']
					[2,	'October, 2015']
					[3,	'November, 2015']
				]
				tickLength: 0
				min: -0.5
				max: data.length - 0.5
			yaxis:
				axisLabel: 'Plays Number'
				color: colorAxis
				axisLabelUseCanvas: yes
				axisLabelFontSizePixels: 12
				axisLabelFontFamily: 'arial,sans serif'
				axisLabelPadding: 10
				# tickFormatter: (v, axis) -> v
				# alignTicksWithAxis: 10
				reserveSpace: yes
				tickLength: 15
				# tickSize: 5
				# min: -1
			legend:
				noColumns: 0
				labelBoxBorderColor: '#000000'
				position: 'nw'
			grid:
				show: yes
				hoverable: yes
				clickable: yes
				# mouseActiveRadius: 10
				borderWidth:
					top: 0
					right: 0
					bottom: borderWidth
					left: borderWidth
				borderColor: colorAxis
				backgroundColor: mainBg
				aboveData: no
				axisMargin: 10
				# markings: (axes) ->
				# 	markings = [
				# 		xaxis:
				# 			from: axes.xaxis.min
				# 			to: axes.xaxis.min
				# 		yaxis:
				# 			from: axes.yaxis.min
				# 			to: axes.yaxis.max
				# 		color: colorAxis
				# 		lineWidth: borderWidth
				# 	,
				# 		xaxis:
				# 			from: axes.xaxis.min
				# 			to: axes.xaxis.max
				# 		yaxis:
				# 			from: axes.yaxis.min
				# 			to: axes.yaxis.min
				# 		color: colorAxis
				# 		lineWidth: borderWidth
				# 	]

				# 	N = (axes.yaxis.max - axes.yaxis.min) / 5
				# 	Ymarkings = for y in [1..N]
				# 		xaxis:
				# 			from: axes.xaxis.min
				# 			to: axes.xaxis.min
				# 		yaxis:
				# 			from: (y-1)*5 + 0.1
				# 			to: y*5 - 0.3
				# 		color: colorAxis
				# 		lineWidth: borderWidth

				# 	M = axes.xaxis.ticks[0].v
				# 	N = axes.xaxis.ticks[axes.xaxis.ticks.length-1].v
				# 	Xmarkings = for x in [M..N]
				# 		xaxis:
				# 			from: x-0.5+0.005
				# 			to: x+0.5-0.005
				# 		yaxis:
				# 			from: axes.yaxis.min
				# 			to: axes.yaxis.min
				# 		color: colorAxis
				# 		lineWidth: borderWidth

				# 	markings.concat Xmarkings.concat Ymarkings