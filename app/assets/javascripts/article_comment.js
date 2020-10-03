$(function(){
  function buildHTML(comment){
    let html = `<div class="comment" data-comment-id="${comment.id}">
                  ${comment.text}
                </div>`
    return html;
  }

  $('#new_article_comment').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let last_comment_id = $('.comment:last').data("comment-id");
    formData.append('last_comment_id', last_comment_id);
    let url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: "JSON",
      processData: false,
      contentType: false
    })
    .done(function(data){
      if ($.isArray(data)) {
        var insertHTML = '';
        $.each(data, function(i, comment) {
          insertHTML += buildHTML(comment);
        });
      } else {
        insertHTML = buildHTML(data);
      }
      
      $('.new_comment').append(insertHTML);
      $('.textarea').val('');
      $('.submit_comment').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })
});