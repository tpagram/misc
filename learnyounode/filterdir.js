fs = require('fs')

fs.readdir(process.argv[2], function filter(err, files) {
  for (var i = 0; i < files.length; i++) {
    if (files[i].split('.').slice(-1)[0] == process.argv[3] &&
          files[i].split('.').length > 1) {
      console.log(files[i])
    }
  }
})