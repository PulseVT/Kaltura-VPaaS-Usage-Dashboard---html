module.exports = (grunt) ->

	require('load-grunt-tasks') grunt

	grunt.initConfig
		config:
			html: 'html'
			styles: '<%= config.html %>/styles'
			less: '<%= config.styles %>/less'

		watch:
			less:
				files: '<%= config.less %>/**/*.less'
				tasks: 'less:html'

		less:
			html:
				files:
					'<%= config.styles %>/usage-dashboard.css': '<%= config.less %>/main.less'

	grunt.registerTask 'default', [
		'less'
		'watch'
	]