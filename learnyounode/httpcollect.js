http = require("http")
url = process.argv[2]

http.get(url, function (response) {
  var characters = ""
  response.setEncoding("utf8")
  response.on("error", console.error)
  response.on("data", function (data) {
    characters += data
  })
  response.on("end", function (something) {
    printResults (characters)
  })
})

function printResults (characters) {
  console.log(characters.length)
  console.log(characters)
}