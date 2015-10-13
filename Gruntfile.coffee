module.exports = (grunt) ->

	require('load-grunt-tasks') grunt

	grunt.initConfig
		config:
			html: 'html'
			html_source: '<%= config.html %>/html-source'
			html_partials: '<%= config.html_source %>/partials'
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
			html:
				files: ['<%= config.html_source %>/*.html', '<%= config.html_partials %>/*.html']
				tasks: 'includes:html'

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

		includes:
			html:
				src: ['<%= config.html_source %>/*.html']
				dest: '<%= config.html %>'
				flatten: yes
				cwd: '.'

	grunt.registerTask 'default', [
		'coffee'
		'less'
		'includes'
		'watch'
	]