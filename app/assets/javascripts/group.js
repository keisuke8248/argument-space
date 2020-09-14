$(function(){
  function buildHTML(comment){
    let html = `${comment.text}`
    return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      $('.comment').append(html);
      $('.textarea').val('');
      $('.submit').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })
})