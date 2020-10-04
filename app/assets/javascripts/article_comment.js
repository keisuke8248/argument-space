$(function(){
  function buildHTML(comment){
    let html = `<div class="comment" data-comment-id="${comment.id}">${comment.text}
                  <form action="/evaluations/good" accept-charset="UTF-8" data-remote="true" method="post">
                    <input name="utf8" type="hidden" value="✓"></input>
                    <input value="${comment.article_id}" type="hidden" name="article_id" id="article_id"></input>
                    <input value="${comment.id}" type="hidden" name="comment_id" id="comment_id"></input>
                    <input type="submit" name="commit" value="good" data-disable-with="good"></input>
                  </form>
                  <form action="/evaluations/bad" accept-charset="UTF-8" data-remote="true" method="post">
                    <input name="utf8" type="hidden" value="✓"></input>
                    <input value="${comment.article_id}" type="hidden" name="article_id" id="article_id"></input>
                    <input value="${comment.id}" type="hidden" name="comment_id" id="comment_id"></input>
                    <input type="submit" name="commit" value="bad" data-disable-with="bad"></input>
                  </form>
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
  var reloadComments = function() {
    var last_comment_id = $('.comment:last').data("comment-id");
    var article_id = $('.title').data("article-id");
    $.ajax({
      url: "/articles/" + article_id + "/article_comments/api",
      type: 'get',
      dataType: 'json',
      data: {last_comment_id: last_comment_id}
    })
    .done(function(data) {
      let insertHTML = '';
      $.each(data, function(i, comment) {
        insertHTML += buildHTML(comment);
      });
      //debugger;
      $('.new_comment').append(insertHTML);
    })
    .fail(function() {
      alert('error');
    });
  };
  //setInterval(reloadComments, 7000);
});