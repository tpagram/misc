var portNumber = process.argv[2]
var net = require("net")

var s = net.createServer(function (socket) {
  var date = new Date()
  currentDate = zeroFill(date.getFullYear()) + "-" 
                + zeroFill(date.getMonth()+1) + "-" 
                + zeroFill(date.getDate()) + " " 
                + zeroFill(date.getHours()) + ":" 
                + zeroFill(date.getMinutes()) + "\n"
  socket.write(currentDate)
  socket.end()
})
s.listen(portNumber)

function zeroFill(n) {
  return n < 10 ? "0" + n : n
}