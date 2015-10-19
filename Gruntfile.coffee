module.exports = (grunt) ->

	require('load-grunt-tasks') grunt
	modrewrite = require 'connect-modrewrite'
	serveStatic = require 'serve-static'

	grunt.initConfig
		config:
			html: 'html'
			html_source: '<%= config.html %>/html-source'
			scripts: '<%= config.html %>/scripts'
			styles: '<%= config.html %>/styles'
			less: '<%= config.styles %>/less'

		connect:
			html:
				options:
					port: 9000
					middleware: (connect, options) ->
						[
							modrewrite [ '!(\\..+)$ /index.html [L]' ]
							serveStatic '.'
						]

		watch:
			less:
				files: '<%= config.less %>/**/*.less'
				tasks: 'less:html'
			coffee:
				files: '<%= config.scripts %>/**/*.coffee'
				tasks: 'coffee:scripts'
			html:
				files: ['<%= config.html_source %>/**/*.html']
				tasks: 'includes:static'

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
			static:
				src: ['<%= config.html_source %>/*.html']
				dest: '<%= config.html %>'
				flatten: yes
				cwd: '.'

	grunt.registerTask 'default', ['serve']

	grunt.registerTask 'build', [
		'coffee'
		'less'
		'includes'
	]

	grunt.registerTask 'serve', [
		'build'
		'connect:html'
		'watch'
	]