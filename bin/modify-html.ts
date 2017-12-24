const fs = require('fs')
const jsdom = require('jsdom')

Promise.all(process.argv.slice(2).map((filename) => {
  fs.readFile(filename, 'utf8', (error, data) => {
    if (error) {
      throw error
    }

    const { window } = new jsdom.JSDOM(data)
    const $ = require('jquery')(window)

    $('a[href^="http://"], a[href^="https://"]').attr('target', '_blank')
    $('code').addClass('highlight')

    fs.writeFile(filename, window.document.documentElement.outerHTML, (error) => {
      if (error) {
        throw error
      }
    })
  })
}))
