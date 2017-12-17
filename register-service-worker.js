if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/service-worker.js').then((reg) => {
    console.log('Registration succeeded:', reg.scope)
  }).catch(console.error)
}
