// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

App.posts = {

    init: function() {
        $('#table-posts').bootstrapTable();
        this.summerNote();
    },

    summerNote: function() {
        $('.summernote').summernote();
    }
};