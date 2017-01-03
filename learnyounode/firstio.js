var fs = require('fs') 

var buffer = fs.readFileSync(process.argv[2])
var fileString = buffer.toString()

console.log(fileString.split('\n').length - 1)