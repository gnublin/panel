"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
require("uikit/dist/js/uikit");
require("jquery-ujs/src/rails");
var graph_1 = require("./graph");
function init() {
    if (jQuery('#chart_area').length > 0) {
        graph_1.init();
    }
}
exports.init = init;
