var http = require("http")
var fs = require("fs")
var port = process.argv[2]
var file  = process.argv[3]

var server = http.createServer(function (request, response) {
  fs.createReadStream(file).pipe(response)
})
server.listen(port)