packagejson = {
    "build_values": {
        "app_name" : "app",
        "build_dir" : "dist"
    }
}

m = require('./gulp/modules')()
{ gulp, through } = m
{ name, version, build_values } = packagejson
{ build_dir, app_name }             = build_values


###*
 * CSS
###
cssTaskList = [
    {
        outFile: "vendor.min.css"
        outDir: "#{build_dir}/css/"
        source: m.main_bower_files filter: (arg) -> arg.indexOf(".css") > -1
    }
    {
        outFile: "app.min.css"
        outDir: "#{build_dir}/css/"
        source: "app/**/*.{less,css,styl}"
    }
]
cssTaskList.forEach (cssTask) ->
    gulp.task cssTask.outFile, ->
        gulp.src cssTask.source
            .pipe through.catch
            .pipe through.less
            .pipe through.styl
            .pipe m.concat cssTask.outFile
            .pipe through.cssMin
            .pipe gulp.dest cssTask.outDir



# ###*
#  * JS
# ###
# jsTaskList = [
#     {
#         outFile: "vendor.js"
#         outDir: "#{build_dir}/css/"
#         src: main_bower_files filter: (arg) -> arg.indexOf(".js") > -1
#     }
#     {
#         outFile: "app.js"
#         outDir: "#{build_dir}/css/"
#         src: "app/**/*.{less,css,styl}"
#     }
# ].forEach (jsTask) ->
#     gulp.task jsTask.outFile, ->
#         gulp.src jsTask.src
#             .pipe through.coffee
#             .pipe concat jsTask.outFile
#             # Minify in release mode
#             .pipe through.uglified
#             .pipe through.minSuffixed
#             .pipe gulp.dest jsTask.outDir

 
# # Precompile angular templates
# gulp.task "ng_tpl", ->
#     gulp.src "app/**/*.template.*"
#         .pipe through.catch
#         .pipe through.jade
#         .pipe through.htmlMin
#         .pipe rename dirname: ""
#         .pipe through.ngHtml
#         .pipe concat "templates.min.js"
#         .pipe through.uglified
#         .pipe gulp.dest "#{build_dir}/js/"

# ###*
#  * VENDOR - MIXED
# ###
# gulp.task "vendor other", ->
#     src_map = main_bower_files filter: (arg) -> arg.indexOf(".map") > -1
#     gulp.src(src_map).pipe check_if its.release, gulp.dest "#{build_dir}/css/" # dup: easy solution
#     gulp.src(src_map).pipe check_if its.release, gulp.dest "#{build_dir}/js/" # dup: easy solution
    
#     src_fonts = main_bower_files filter: (arg) -> arg.search(/.(eot|svg|ttf|woff)/) > -1
#     gulp.src(src_fonts).pipe gulp.dest "#{build_dir}/fonts/" # dup: easy solution
#     gulp.src(src_fonts).pipe gulp.dest "#{build_dir}/css/" # dup: easy solution

#     src_swf = main_bower_files filter: (arg) -> arg.search(/.swf/) > -1
#     gulp.src(src_swf).pipe gulp.dest "#{build_dir}/swf/"

# ###*
#  * ASSETS
# ###


# [
#     {
#         name: "flash"
#         src: "app/assets/flash/*.swf"
#         dest: "#{build_dir}/flash"
#     },
#     {
#         name: "images"
#         src: "app/assets/images/**/*.{gif,png,svg,jpg,jpeg}"
#         dest: "#{build_dir}/images"
#     },

# ].forEach (assetTask) ->
#     gulp.task , (assetTask.name) ->
#         gulp.src assetTask.src
#             .pipe gulp.dest assetTask.dest



###*
 * RELEASE VERSIONS
###

# # Finalize js
# gulp.task "js_release", JS_ALL, ->
#     src = [
#         "#{build_dir}/js/vendor.min.js"
#         "#{build_dir}/js/app.min.js"
#         "#{build_dir}/js/templates.min.js"
#     ]
#     gulp.src src
#         .pipe concat "app.min.js"
#         .pipe gzip gzipOptions: level: 9
#         .pipe gulp.dest "#{build_dir}/js/"


# # Finalise css
# gulp.task "css_release", CSS_ALL, () ->
#     gulp.src sources.css_release
#         .pipe concat "release.min.css"
#         .pipe gzip gzipOptions: level: 9
#         .pipe gulp.dest "#{build_dir}/css/"


###*
 * Utility
###

# Server
# gulp.task "serve", ->
#     connect.server
#         middleware: (connect, options, next) ->
#             [
#                 (req, res, next) ->
#                     res.setHeader "Access-Control-Allow-Origin", "*"
#                     next()
#             ]
#         port: 8081

# Watch
# default_tasks = CSS_ALL.concat(JS_ALL).concat(OTHER_ALL)

# gulp.task "watch", default_tasks.concat(["serve"]), () ->
#     gulp.watch sources.css_watch, ["css", "components_css"]
#     gulp.watch ["app/{components,ng-components}/**/*.style.*"], ["components_css"]
#     gulp.watch ["app/src/*.coffee", "!app/src/**/*.directive.coffee"], ["js_ng"]
#     gulp.watch ["app/src/**/*.directive.coffee"], ["directives"]
#     gulp.watch ["app/**/*.controller.coffee"], ["controllers"]
#     gulp.watch ["app/**/*.service.coffee"], ["services"]
#     gulp.watch ["app/**/*.value.coffee"], ["services"]
#     gulp.watch ["app/**/*.constant.coffee"], ["services"]
#     gulp.watch ["app/**/*.template.*"], ["ng_tpl"]
#     gulp.watch ["bower_components/**/bower.json"], ["vendor"]
#     gulp.watch "npmlastupdate.nogit.log", ["vendor"]
#     gulp.watch sources.in_bro, ["in_bro_build"]
#     unless process.env.CI_BUILD
#         gulp.watch sources.stub, ["stub"]



# gulp.task "build", default_tasks.concat(["css_release", "js_release", "build_check", "in_bro_build"])

