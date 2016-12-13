// See http://brunch.io for documentation.
module.exports = {
  paths: {
    watched: ['app/brunch'],
    public: 'vendor/assets'
  },

  modules: {
    wrapper: false
  },

  files: {
    javascripts: {joinTo: 'javascripts/brunch/app.js'},
    stylesheets: {joinTo: 'stylesheets/brunch/app.css'}
  },

  plugins: {
    sass: {
      options: {
        includePaths: ['node_modules']
      }
    },
    copycat: {
      fonts: ["node_modules/uikit/dist/fonts"],
      onlyChanged: true
    }
  }
}
