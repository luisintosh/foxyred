// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

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
            },
            tick: {
                format: function (d) {
                    return (parseInt(d) == d) ? d : null;
                }
            }
        },
    }
});