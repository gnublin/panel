import 'uikit/dist/js/uikit'
import 'jquery-ujs/src/rails'
import {init as graphInit} from './graph'

export function init() {
  // Load "global" packages
  if (jQuery('#chart_area').length > 0) {
    graphInit()
  }

  jQuery('[data-filter]').click((e) => {
    const filter = e.target.dataset.filter
    const all_bstats = document.querySelector(".chart_area")
    const all_bstats_el = all_bstats.childNodes

    for (let d = 0, e = all_bstats_el.length; d < e ; d++ ) {
      let is_in_array = filter.indexOf(all_bstats_el[d].getAttribute("class"))
      if (is_in_array > -1 || filter == "all") {
        all_bstats_el[d].style.display = "block"
      }
      else {
        all_bstats_el[d].style.display = "none"
      }
    }

    return false
  })
}
