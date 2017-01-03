fs = require('fs')


function readAndFilter(dir, ext, callback) {
  fs = require('fs')
  fs.readdir(dir, function filter(err, files) {
    if (err) return callback(err)
    var filteredFiles = []
    for (var i = 0; i < files.length; i++) {
      if (files[i].split('.').slice(-1)[0] == ext &&
            files[i].split('.').length > 1) {
        filteredFiles.push(files[i])
      }
    }
    callback(null, filteredFiles)
  })
}

module.exports = readAndFilter