import 'uikit/dist/js/uikit'
import 'jquery-ujs/src/rails'
import {init as graphInit} from './graph'

export function init() {
  // Load "global" packages
  if (jQuery('#chart_area').length > 0) {
    graphInit()
  }
}
