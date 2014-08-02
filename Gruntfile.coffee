module.exports = (grunt) ->
  # time to initialize grunt describing what
  # we want to accomplish with the tasks
  grunt.initConfig
   # juice task is our css inliner
    stylus:
      files: ['emails/**/*.styl']
      dynamic_mappings:
        files: [
          {
            expand: true
            cwd: 'emails/'
            src: ['**/*.styl']
            # we are taking everything from
            dest: 'emails/'
            ext: '.css'
          }
        ]
    juice:
      # in grunt, a dynamic mapping differs
      # from normal mapping in that you
      # can define a "src" path and everything
      # in ther can be reproduced in a "dest" path
      dynamic_mappings:
        files: [
          {
            expand: true
            cwd: 'emails/'
            src: ['**/*.html']
            # we are taking everything from
            dest: 'build/'
            ext: '.html'
          }
        ]
      # watch will be used to watch two different
      # paths in our project
    watch:
      # every change you do to the source code of
      # the emails will be passed through the inliner
      build:
        files: ['emails/**/*.html', 'emails/**/*.styl']
        tasks: ['stylus','juice']
      # as soon as the built files arrive to the
      # build directory, livereload will reload
      # the page in your browser
      reload:
        files: ['build/**/*']
        options:
          livereload: true

  grunt.loadNpmTasks('grunt-juice-email')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-stylus')

