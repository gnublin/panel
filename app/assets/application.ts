declare function require(what: string): any;

export function init() {
  // Load "global" packages
  require('uikit/dist/js/uikit')
  require('jquery-ujs/src/rails')
}
