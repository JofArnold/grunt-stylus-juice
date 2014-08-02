module.exports = (grunt) ->
  # time to initialize grunt describing what
  # we want to accomplish with the tasks
  grunt.initConfig
   # juice task is our css inliner
    stylus:
      compile:
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
      options:
        removeStyleTags: false
        applyStyleTags: false
      compile:
        tasks: ['htmlmin']
        files: [
          {
            expand: true
            cwd: 'emails/'
            src: ['**/*.html']
            # we are taking everything from
            dest: 'tmp/'
            ext: '.html'
          }
        ]
    htmlmin:
      compile:
        options:
          removeComments: true
          collapseWhitespace: true
        files: [
          {
            expand: true
            cwd: 'tmp/'
            src: ['**/*.html']
            # we are taking everything from
            dest: 'build/'
            ext: '.html'
          }
        ]

    watch:
      # every change you do to the source code of
      # the emails will be passed through the inliner
      build:
        files: ['emails/**/*.html', 'emails/**/*.styl']
        tasks: ['stylus','juice','htmlmin']
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
  grunt.loadNpmTasks('grunt-contrib-htmlmin')

