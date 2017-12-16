const UglifyJsPlugin = require('uglifyjs-webpack-plugin')

module.exports = {
    node: {module: "empty", net: "empty", fs: "empty"},

    plugins: [
//        new UglifyJsPlugin()
    ],

    entry:
        "./js/abc.js",

    output:
        {
            library: "abc",
            libraryTarget: "var",
            filename:
                "js/abcBundle.js"
        }
}
