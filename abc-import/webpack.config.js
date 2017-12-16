module.exports = {
    node: {module: "empty", net: "empty", fs: "empty"},

//    context: __dirname + "/app",
    entry:
        "./js/abc.js",
    output:
        {
            library: "abc",
            libraryTarget: "var",
//            path: __dirname + "/dist",
            filename:
                "js/abcBundle.js"
        }
}
