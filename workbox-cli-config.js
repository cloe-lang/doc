module.exports = {
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
