
App.userpanel = {

    init: function(){},

    start: function () {
        if ($('.userpanel').length === 0) return;
        this.copyClipboard();
        this.shortlinkForm();
    },

    copyClipboard: function() {
        // Clipboard copy init
        new Clipboard('.btn-copy');
    },

    shortlinkForm: function() {
        $(document).on('click', '.btn-copy', function(e) {
            var self = $(this);
            self.addClass('animated tada');
            setTimeout(function() {
                self.removeClass('animated tada');
            }, 1000);
        
        }).on('ajax:success', '#new_link', function (e, data, status, xhr) {
            
            var html = [
                '<div id="new_link_actions">',
                '<button class="btn btn-lg btn-danger btn-copy" data-clipboard-text="{{ url }}"><i class="font-icon font-icon-heart"></i> Copy</button>',
                '<button class="btn btn-lg btn-primary share_link"><i class="fa fa-share"></i> Share</button>',
                '<div style="display:none"><div class="addthis_toolbox"><span class="custom_images"><a class="addthis_button_more" addthis:url="{{ url }}"></a></span></div></div>',
                '</div>'
            ].join('');
            
            swal({
                title: data.short_url,
                text: html.replace(/\{\{ url \}\}/g, data.short_url),
                type: 'success',
                confirmButtonClass: 'btn-success btn-sm',
                confirmButtontText: 'OK',
                html: true
            });

            addthis.toolbox('.addthis_toolbox');

            $('#table-links').bootstrapTable('refresh');
            $('#link_url').val('');
            
        }).on('ajax:error', '#new_link', function (xhr, status, error) {

            swal('Error!', 'Uh oh! We have a problem.', 'error');

        }).on('click', '#new_link_actions .share_link', function (e) {
            // when user click on share button
            $('#new_link_actions .addthis_button_more').click();
        });
    }
};