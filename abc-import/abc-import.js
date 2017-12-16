.pragma library

Qt.include("js/abcBundle.js");

function getTree(input) {
    var antlr4 = abc.antlr4;
    var abcLexer = abc.abcLexer;
    var abcParser = abc.abcParser;
    var abcParserListener = abc.abcParserListener;

    var chars = new antlr4.InputStream(input);

    var lexer = new abcLexer.abcLexer(chars);
    var tokens = new antlr4.CommonTokenStream(lexer);
    var parser = new abcParser.abcParser(tokens);

    parser.buildParseTrees = true;

    return parser.abc_file();
}
