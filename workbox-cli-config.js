const glob = require('glob')
const path = require('path')

module.exports = {
  templatedUrls: Object.assign(...glob.sync('_site/**/*.html').map((filename) => {
    if (path.basename(filename) === 'index.html') {
      return {}
    }

    return {[filename.slice(6, -5)]: filename}
  })),
  globDirectory: '_site/',
  globPatterns: [
    '**/*.{css,html,js,json,png}'
  ],
  globIgnores: [
    'register-service-worker.js',
    'service-worker.js'
  ],
  swDest: 'service-worker.js'
}
