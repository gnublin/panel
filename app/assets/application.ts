import 'uikit/dist/js/uikit'
import 'jquery-ujs/src/rails'
import {init as graphInit} from './graph'

export function init() {
  // Load "global" packages
  if (jQuery('#chart_area').length > 0) {
    graphInit()
  }

  jQuery('[data-filter]').click((e) => {

    if (e.target.getAttribute("data-filter") == 'all')
    {
      let all_el = jQuery('[data-filter]')
      for (let g=0, f=all_el.length ; g < f ; g++) {
        if (all_el[g].getAttribute("data-filter") != 'all') {
          all_el[g].style.backgroundColor = ""
          all_el[g].setAttribute('data-active', 'false')
        }
      }
    }
    else {
      jQuery('[data-filter="all"]')[0].style.backgroundColor = ""
      jQuery('[data-filter="all"]')[0].setAttribute('data-active', 'false')
    }


    if (e.target.style.backgroundColor ) {
      e.target.style.backgroundColor = ""
      e.target.setAttribute('data-active', 'false')
    }
    else if (e.target.getAttribute('data-filter') != "all") {
      e.target.style.backgroundColor = "#61ABFE"
      e.target.setAttribute('data-active', 'true')
    }

    selectGraph()
  })


}


export function selectGraph() {
    const active_elements = jQuery('[data-active="true"]')

    let active_filters = []
    for (let x = 0, y = active_elements.length; x < y; x++) {
      let new_filter = active_filters.push(active_elements[x].getAttribute('data-filter'))
    }

    const all_bstats = document.querySelector(".chart_area")
    const all_bstats_el = all_bstats.childNodes

    for (let d = 0, e = all_bstats_el.length; d < e ; d++ ) {
      let is_in_array = active_filters.indexOf(all_bstats_el[d].getAttribute("class"))
      if (is_in_array > -1 || active_filters[0] == "all" || active_filters.length == 0) {
        all_bstats_el[d].style.display = "block"
      }
      else {
        all_bstats_el[d].style.display = "none"
      }
    }

    return false

}
