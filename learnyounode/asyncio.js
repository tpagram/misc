var fs = require('fs') 

var buffer = fs.readFile(process.argv[2], countLines)

function countLines(err, buf) {
  var fileString = buf.toString()
  console.log(fileString.split('\n').length - 1)
}