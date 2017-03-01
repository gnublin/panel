// See http://brunch.io for documentation.
module.exports = {
  paths: {
    watched: ['app/assets'],
    public: 'public/assets'
  },
  files: {
    javascripts: {
      joinTo: {
        'application.js': /^app/,
        'vendor.js': /^(?!app)/
      }
    },
    stylesheets: { joinTo: 'application.css' }
  },
  conventions: {
    assets: /^app\/assets\/static\//
  },
  modules: {
    nameCleaner: path => path.replace(/^app\/assets\//, '')
  },
  plugins: {
    autoReload: {
      enabled: true
    },
    typescript: {},
    sass: {
      mode: 'native',
      options: {
        includePaths: ['app/assets', 'node_modules']
      }
    },
    copycat: {
      fonts: ['node_modules/uikit/dist/fonts/']
    }
  },
  npm: {
    static: [
      'uikit/dist/js/uikit',
      'jquery-ujs/src/rails'
    ],
    globals: {
      jQuery: 'jquery'
    }
  }
}
