module.exports = (modules) ->
    { check_if, less, stylus, cssmin, coffee, uglify, rename, its, jade, htmlmin, plumber, ng_html } = modules
    handleError = (err) ->
        notify.onError(
            title: "Gulp"
            subtitle: "Failure!"
            message: "Error: <%= error.message %>"
            sound: "Beep"
        ) err
        @emit "end"

    return {
        less: check_if its.containing('.less'), less()
        styl: check_if its.containing('.styl'), stylus()
        cssMin:  check_if its.release, cssmin()

        coffee: check_if its.coffee, coffee { bare: true }
        uglified: check_if its.release, uglify mangle: false
        minSuffixed: check_if its.release, rename suffix: ".min"

        jade: check_if its.jade, jade locals: {}
        htmlMin: htmlmin collapseWhitespace: true

        catch: plumber { handleError }

        ngHtml: ng_html moduleName: 'app', prefix: "ngHtml:"
    }