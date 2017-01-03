var filterModule = require('./filtermodule.js')

filterModule(process.argv[2],process.argv[3], function (err,files) {
  if (err) return console.error(err)
  for (var i = 0; i < files.length; i++) {
    console.log(files[i])
  }
})