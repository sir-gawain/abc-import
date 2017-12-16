#! /usr/bin/make

ANTLR = /usr/bin/java -cp . -jar /opt/antlr-4.7.1-complete.jar

all: js/abcBundle.js

js/abcBundle.js: js/abc.js js/abcImporter.js parser/abcLexer.js parser/abcParser.js webpack.config.js $(wildcard node_modules/**/*)
	npx webpack

parser/abcLexer.js: grammar/abcLexer.g4
	$(ANTLR) -Dlanguage=JavaScript grammar/abcLexer.g4
	mv grammar/abcLexer.js parser/
	mv grammar/abcLexer.tokens parser/

parser/abcParser.js: grammar/abcParser.g4
	$(ANTLR) -Dlanguage=JavaScript -lib parser/ grammar/abcParser.g4
	mv grammar/abcParser.js parser/
	mv grammar/abcParser.tokens parser/
	mv grammar/abcParserListener.js parser/

clean:
	rm grammar/*.interp
	rm parser/*.js
	rm parser/*.tokens
	rm js/abcBundle.js

.PHONY: clean
