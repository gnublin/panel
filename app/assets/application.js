"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
require("uikit/dist/js/uikit");
require("jquery-ujs/src/rails");
var graph_1 = require("./graph");
function init() {
    if (jQuery('#chart_area').length > 0) {
        graph_1.init();
    }
    jQuery('[data-filter]').click(function (e) {
        if (e.target.getAttribute("data-filter") == 'all') {
            var all_el = jQuery('[data-filter]');
            for (var g = 0, f = all_el.length; g < f; g++) {
                if (all_el[g].getAttribute("data-filter") != 'all') {
                    all_el[g].style.backgroundColor = "";
                    all_el[g].setAttribute('data-active', 'false');
                }
            }
        }
        else {
            jQuery('[data-filter="all"]')[0].style.backgroundColor = "";
            jQuery('[data-filter="all"]')[0].setAttribute('data-active', 'false');
        }
        if (e.target.style.backgroundColor) {
            e.target.style.backgroundColor = "";
            e.target.setAttribute('data-active', 'false');
        }
        else if (e.target.getAttribute('data-filter') != "all") {
            e.target.style.backgroundColor = "#61ABFE";
            e.target.setAttribute('data-active', 'true');
        }
        selectGraph();
    });
}
exports.init = init;
function selectGraph() {
    var active_elements = jQuery('[data-active="true"]');
    var active_filters = [];
    for (var x = 0, y = active_elements.length; x < y; x++) {
        var new_filter = active_filters.push(active_elements[x].getAttribute('data-filter'));
    }
    var all_bstats = document.querySelector(".chart_area");
    var all_bstats_el = all_bstats.childNodes;
    for (var d = 0, e = all_bstats_el.length; d < e; d++) {
        var is_in_array = active_filters.indexOf(all_bstats_el[d].getAttribute("class"));
        if (is_in_array > -1 || active_filters[0] == "all" || active_filters.length == 0) {
            all_bstats_el[d].style.display = "block";
        }
        else {
            all_bstats_el[d].style.display = "none";
        }
    }
    return false;
}
exports.selectGraph = selectGraph;
