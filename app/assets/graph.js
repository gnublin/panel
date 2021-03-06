"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var d3 = require("d3");
function init() {
    var svg = d3.select("#chart_area").append("svg").attr("width", "1000px").attr("height", "1000px").attr("class", "chart_area");
    var runId = window.location.pathname.split("/")[2];
    var filter_type = document.getElementById("chart_area").getAttribute("data-filter");
    jQuery.ajax({
        url: "/runs/" + runId + ".json",
        type: "GET",
        data: 'you data',
        dataType: 'JSON',
        success: function (json) {
            var dataset = json.log.entries;
            var total_time = json['log']['pages'][0]['pageTimings']['onLoad'];
            var start_time_iso = json['log']['pages'][0]['startedDateTime'];
            var dateObj = new Date(start_time_iso);
            var start_time = dateObj.getTime();
            var W = 1000;
            var H = 1000;
            var L = total_time;
            svg.selectAll("rect")
                .data(dataset)
                .enter()
                .append("rect")
                .attr("x", 0)
                .attr("y", 0)
                .attr("width", 10)
                .attr("height", 20)
                .attr("y", function (d, i) {
                return i * 50 + 45;
            })
                .attr("x", function (d) {
                var dateObj_tmp = new Date(d.startedDateTime);
                var time_tmp = dateObj_tmp.getTime();
                var x_time = time_tmp - start_time;
                return x_time * W / L;
            })
                .attr("width", function (d) {
                return d.time * W / L;
            })
                .text(function (d) {
                return d.nameid;
            })
                .attr("fill", function (d) {
                var myTenHold = total_time / 10;
                var myEightHold = total_time / 8;
                var myFourHold = total_time / 4;
                var myColor = "#2A75C9";
                if (d.time > myTenHold) {
                    myColor = "#114B8C";
                }
                if (d.time > myEightHold) {
                    myColor = "#004BA1";
                }
                if (d.time > myFourHold) {
                    myColor = "#00234A";
                }
                return myColor;
            })
                .attr("class", function (d) {
                return d['response']['content']['mimeType'];
            });
            svg.selectAll("text")
                .data(dataset)
                .enter()
                .append("text")
                .attr("x", 0)
                .attr("y", 0)
                .attr("width", 10)
                .attr("height", 20)
                .text(function (d) {
                return d['request']['url'];
            })
                .attr("y", function (d, i) {
                return i * 50 + 35;
            })
                .attr("width", function (d) {
                return d.time * W / L;
            })
                .attr("class", function (d) {
                return d['response']['content']['mimeType'];
            });
            var x = d3.time.scale().range([0, 600]);
            var y = d3.scale.linear().range([1000, 0]);
            function make_x_axis() {
                return d3.svg.axis()
                    .scale(x)
                    .orient("bottom")
                    .ticks(5);
            }
            function make_y_axis() {
                return d3.svg.axis()
                    .scale(y)
                    .orient("left")
                    .ticks(5);
            }
            svg.append("g")
                .attr("class", "grid")
                .attr("transform", "translate(0," + 200 + ")")
                .call(make_x_axis()
                .tickSize(-200, 0, 0)
                .tickFormat(""));
            svg.append("g")
                .attr("class", "grid")
                .call(make_y_axis()
                .tickSize(-200, 0, 0)
                .tickFormat(""));
        },
    });
}
exports.init = init;
