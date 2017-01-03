http = require("http")
url1 = process.argv[2]
url2 = process.argv[3]
url3 = process.argv[4]

function getContent(url, callback) {
  var characters = ""
  http.get(url, function (response) {
    response.setEncoding("utf8")
    response.on("error", console.error)
    response.on("data", function (data) {
      characters += data
    })
    response.on("end", function (something) {
      console.log(characters)
      if (callback) callback()
    })
  })
}

getContent(url1, getContent(url2, getContent(url3, null)))