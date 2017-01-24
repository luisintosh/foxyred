// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require theme/js/lib/charts-c3js/c3.min.js
//= require theme/js/lib/d3/d3.min.js

var chart = c3.generate({
    bindto: '#chart',
    data: {
        url: '/dashboard/chart_data',
        mimeType: 'json'
    },
    axis: {
        y: {
            label: { // ADD
            text: 'Views',
            position: 'outer-middle'
            }
        },
    }
});