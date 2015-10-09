module.exports = (grunt) ->

	require('load-grunt-tasks') grunt

	grunt.initConfig
		config:
			html: 'html'
			scripts: '<%= config.html %>/scripts'
			styles: '<%= config.html %>/styles'
			less: '<%= config.styles %>/less'

		watch:
			less:
				files: '<%= config.less %>/**/*.less'
				tasks: 'less:html'
			coffee:
				files: '<%= config.scripts %>/**/*.coffee'
				tasks: 'coffee:scripts'

		coffee:
			scripts:
				options:
					bare: yes
				files:
					'<%= config.scripts %>/scripts.js': ['<%= config.scripts %>/**/*.coffee']

		less:
			html:
				files:
					'<%= config.styles %>/usage-dashboard.css': '<%= config.less %>/main.less'

	grunt.registerTask 'default', [
		'coffee'
		'less'
		'watch'
	]