$(function(){
  function buildHTML(comment){
    let html = `<p>
                  ${comment.text}
                  ${comment.nickname}
                  ${comment.date}
                  <form class="vote_btn" action="/favorites" accept-charset="UTF-8" method="post">
                    <input name="utf8" type="hidden" value="✓"></input>
                    <input value="${comment.user_id}" type="hidden" name="favorite[user_id]" id="favorite_user_id"></input>
                    <input value="${comment.id}" type="hidden" name="favorite[comment_id]" id="favorite_comment_id"></input>
                    <input type="submit" name="commit" value="投票する" class="submit_vote" data-disable-with="投票する"></input>
                    <div class="vote_count" data-comment-id="${comment.id}"></div>
                  </form>
                </p>`
    return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action');
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
      $('.comments').append(html);
      $('.textarea').val('');
      $('.submit_comment').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })
  let reloadComments = function(){ //コメント自動更新機能 後ほど実装予定
    let last_comment_id = $('.comment:last').data("message-id");
    let group_id = $('.groupTitle').data("group-id");
    $.ajax({
      url: "group/" +`${group_id}` + "/api",
      type: 'get',
      dataType: 'json',
      data: {last_comment_id: last_comment_id}
    })
    .done(function(comments){
      let insertHTML = "";
      $.each(comments, function(i, comment){
        insertHTML += buildHTML(comment);
      });
    })
    .fail(function(){
      arert('error');
    })
  };
});