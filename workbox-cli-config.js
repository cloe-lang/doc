module.exports = {
  'globDirectory': '_site/',
  'globPatterns': [
    '**/*.{png,html,json}'
  ],
  'swDest': 'service-worker.js',
  'globIgnores': [
    '../workbox-cli-config.js',
    'node_modules',
    'package.json',
    'package-lock.json'
  ]
}
