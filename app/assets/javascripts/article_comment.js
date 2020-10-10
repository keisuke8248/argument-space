$(function(){
  function buildHTML(comment){
    let html = `<div class="comment" data-comment-id="${comment.id}">${comment.index}: ${comment.text}
                  <form class="evaluation_form_good" action="/evaluations/good" accept-charset="UTF-8" method="post">
                    <input name="utf8" type="hidden" value="✓"></input>
                    <input value="${comment.article_id}" type="hidden" name="article_id" id="article_id"></input>
                    <input value="${comment.id}" type="hidden" name="comment_id" id="comment_id"></input>
                    <input class="good_btn" type="submit" name="commit" value="good" data-disable-with="good"></input>
                  </form>
                  <div class="count_good">0</div>
                  <form class="evaluation_form_bad" action="/evaluations/bad" accept-charset="UTF-8" method="post">
                    <input name="utf8" type="hidden" value="✓"></input>
                    <input value="${comment.article_id}" type="hidden" name="article_id" id="article_id"></input>
                    <input value="${comment.id}" type="hidden" name="comment_id" id="comment_id"></input>
                    <input class="bad_btn" type="submit" name="commit" value="bad" data-disable-with="bad"></input>
                  </form>
                  <div class="count_bad">0</div>
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
      $('.text_area').val('');
      $('.submit_comment').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })


  var reloadComments = function() {
    var last_comment_id = $('.comment:last').data("comment-id");
    var article_id = $('.article__title').data("article-id");
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
      $('.new_comment').append(insertHTML);
    })
    .fail(function() {
      alert('error');
    });
  };

  if (document.location.href.match(/\/articles\/\d+\/article_comments/)) {
    //setInterval(reloadComments, 7000);
  }

  $('.comment__index').on('click', function(){
    var textarea = $('.text_area')
    var index = $(this).data('index');
    var inputVal = '>>' + `${index}` +'\n';
    textarea.val(textarea.val() + inputVal);
  });

  var comment = $('.comment__text');
  var length = comment.length;
  for (var i=1; i<=length; i++) {
    comment.each(function(I, e) {
      var text = $(e).text();
      var pattern = new RegExp(`>>${i}`);
      var result = pattern.test(text);
      if (result === true) {
        var reply = $(`.comment__reply__content[data-index=${i}]`);
        var comment = $(e).parent('.comment')
        const appendComment = comment.clone();
        reply.append(appendComment);
      }
    });
  }

  $(document).on('click','.comment__reply#hide', function() {
    var reply = $(this).children('.comment__reply__content');
    reply.show();
    $(this).removeAttr('id');
    $(this).attr('id', 'show');
  })
  $(document).on('click','.comment__reply#show', function(){
    var reply = $(this).children('.comment__reply__content');
    reply.hide();
    $(this).removeAttr('id');
    $(this).attr('id', 'hide');
  });
});