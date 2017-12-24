const glob = require('glob')
const path = require('path')

module.exports = {
  templatedUrls: Object.assign(...glob.sync('_site/**/*.html').map((filename) => {
    const dirname = path.dirname(filename).slice(5)

    if (path.basename(filename) === 'index.html' && dirname !== '') {
      return {[dirname]: filename}
    }

    return {}
  })),
  globDirectory: '_site',
  globPatterns: [
    '**/*'
  ],
  globIgnores: [
    'register-service-worker.js',
    '*.map'
  ],
  swDest: '_site/service-worker.js'
}
