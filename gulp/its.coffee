module.exports = (gutil) ->
    return {
        containing: (ext) ->
            return (file) ->
                return file.path.indexOf("." + ext) > -1

        minify: () ->
            return (typeof gutil.env["skip-min"] is "undefined") or gutil.env.release?

        release: () ->
            return gutil.env.release?
    }