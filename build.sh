out=commonjs.js
echo "// `git ls-remote --get-url origin`" > $out
coffee --stdio --print < commonjs.coffee >> $out
coffee -c specs.coffee
mocha-phantomjs reporter.html
