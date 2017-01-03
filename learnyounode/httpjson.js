var http = require("http")
var url = require("url")
var port = process.argv[2]

var server = http.createServer(function (request, response) {
  var urlHit = url.parse(request.url, true)
  if (urlHit.pathname == "/api/parsetime") {
    var time = new Date(urlHit.query["iso"])
    var timeResponse = {hour: time.getHours(), minute: time.getMinutes(), second: time.getSeconds()}
    response.writeHead(200, { 'Content-Type': 'application/json' })
    response.end(JSON.stringify(timeResponse))
  }
  else if (urlHit.pathname == "/api/unixtime") {
    var epochTime = Date.parse(urlHit.query["iso"])
    var timeResponse = {unixtime: epochTime}
    response.writeHead(200, { 'Content-Type': 'application/json' })
    response.end(JSON.stringify(timeResponse))
  }
  else {
    res.writeHead(404)
    response.end()
  }
})
server.listen(port)