
App.userpanel = {

    init: function () {
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
        
        }).on('focusin', '.shortlink-form input', function (e) {
            // effects on #new_link
            $(this).closest('.form-group').addClass('expand');

        }).on('focusout', '.shortlink-form input', function (e) {
            // effects on #new_link
            $(this).closest('.form-group').removeClass('expand');

        }).on('submit', '#new_link', function (e) {
            // when submit form
            e.preventDefault();

            var linkurl = $('#link_url').val();
            $('#link_url').val('');

            var submitbtn = $('#new_link button[type="submit"]').html();
            $('#new_link button[type="submit"]').html('<i class="fa fa-cog fa-spin fa-fw"></i>');

            var html = [
                '<div id="new_link_actions">',
                '<button class="btn btn-lg btn-danger btn-copy" data-clipboard-text="{{ url }}"><i class="font-icon font-icon-heart"></i> Copy</button>',
                '<button class="btn btn-lg btn-primary share_link"><i class="fa fa-share"></i> Share</button>',
                '<div style="display:none"><div class="addthis_toolbox"><span class="custom_images"><a class="addthis_button_more" addthis:url="{{ url }}"></a></span></div></div>',
                '</div>'
            ].join('');

            $.ajax({
                url: '/panel/links.json',
                type: 'post',
                data: {link: {url: linkurl}},
                dataType: 'json',
                success: function (result,status,xhr) {
                    swal({
                        title: result.short_url,
                        text: html.replace(/\{\{ url \}\}/g, result.short_url),
                        type: 'success',
                        confirmButtonClass: 'btn-success btn-sm',
                        confirmButtontText: 'OK',
                        html: true
                    });

                    addthis.toolbox('.addthis_toolbox');
                    $('#new_link').find('input[type="submit"]').removeAttr('disabled');
                    $('#new_link button[type="submit"]').html(submitbtn);

                    $('#table-links').bootstrapTable('refresh');
                },
                error: function (result,status,xhr) {
                    swal('Error!', 'Uh oh! We have a problem.', 'error');
                    $('#new_link').find('input[type="submit"]').removeAttr('disabled');
                    $('#new_link button[type="submit"]').html(submitbtn);
                    //console.log(result);
                }
            });

        }).on('click', '#new_link_actions .share_link', function (e) {
            // when user click on share button
            $('#new_link_actions .addthis_button_more').click();
        });
    }
};