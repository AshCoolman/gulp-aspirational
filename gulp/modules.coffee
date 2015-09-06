module.exports = ->
    m = {}
    m.main_bower_files = require "main-bower-files"
    m.gulp             = require "gulp"
    m.check_if         = require "gulp-if"
    m.coffee           = require "gulp-coffee"
    m.connect          = require "gulp-connect"
    m.concat           = require "gulp-concat"
    m.cssmin           = require "gulp-cssmin"
    m.gutil            = require "gulp-util"
    m.gzip             = require "gulp-gzip"
    m.htmlmin          = require "gulp-htmlmin"
    m.jade             = require "gulp-jade"
    m.less             = require "gulp-less"
    m.ng_annotate      = require "gulp-ng-annotate"
    m.ng_html          = require "gulp-ng-html2js"
    m.plumber          = require "gulp-plumber"
    m.rename           = require "gulp-rename"
    m.uglify           = require "gulp-uglify"
    m.stylus           = require "gulp-stylus"
    m.replace          = require 'gulp-replace'
    m.its              = require('./its')(m.gutil)
    m.through          = require('./through')(m)
    console.log m.its
    return m