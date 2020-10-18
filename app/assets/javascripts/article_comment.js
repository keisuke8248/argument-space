$(function(){

  function buildHTML(comment){

      let html = `<div class="comment" data-comment-id=${comment.id}>
                      <div class="comment__detail">
                        <div class="comment__index" data-index="${comment.index}">
                          <a class="indexLink" href="#index">
                          ${comment.index}:
                          </a>
                        </div>
                        <a class="comment__detail__nickname" href="user/${comment.user_id}">
                          ${comment.nickname}
                        </a>
                        <div class="comment__detail__date">
                          ${comment.date}
                        </div>
                      </div>
                      <div class="comment__text">
                        ${comment.text}
                      </div>
                      <div class="comment__evaluation">
                        <div class="comment__evaluation__form">
                          <form class="evaluation_form_good" action="/evaluations/good" accept-charset="UTF-8" method="post">
                            <input name="utf8" type="hidden" value="✓"></input>
                            <input value=${comment.article_id} type="hidden" name="article_id" id="article_id"></input>
                            <input value=${comment.id} type="hidden" name="comment_id" id="comment_id"></input>
                            <button name="button" type="submit" class="good_btn" disabled="disabled">
                              <i class="fas fa-thumbs-up">
                                <span class="count_good">0</span>
                              </i>
                            </button>
                          </form>
                        </div>
                        <div class="comment__evaluation__form">
                          <form class="evaluation_form_bad" action="/evaluations/bad" accept-charset="UTF-8" method="post">
                            <input name="utf8" type="hidden" value="✓"></input>
                            <input value=${comment.article_id} type="hidden" name="article_id" id="article_id"></input>
                            <input value=${comment.id} type="hidden" name="comment_id" id="comment_id"></input>
                            <button name="button" type="submit" class="bad_btn" disabled="disabled">
                              <i class="fas fa-thumbs-down">
                                <span class="count_bad">0</span>
                              </i>
                            </button>
                          </form>
                        </div>
                      </div>
                      <div class="comment__reply" id="hide">
                        <div class="comment__reply__btn">
                          <div class="comment__reply__text">返信</div>
                          <div class="comment__reply__count" data-index=${comment.index}>0</div>
                        </div>
                      <div class="comment__reply__content"></div>
                    </div>
                  </div>
                  <div class="new_comment"></div>`
    return html;
  }

  function buildREPLY(comment) {
    
    let html = `<div class="comment" id="reply" data-comment-id=${comment.id}>
                 <div class="comment__detail">
                   <div class="comment__index" data-index="${comment.index}">
                     <a class="indexLink" href="#index">
                     ${comment.index}:
                     </a>
                   </div>
                   <a class="comment__detail__nickname" href="user/${comment.user_id}">
                     ${comment.nickname}
                   </a>
                   <div class="comment__detail__date">
                     ${comment.date}
                   </div>
                 </div>
                 <div class="comment__text">
                   ${comment.text}
                 </div>
                 <div class="comment__evaluation">
                   <div class="comment__evaluation__form">
                     <form class="evaluation_form_good" action="/evaluations/good" accept-charset="UTF-8" method="post">
                       <input name="utf8" type="hidden" value="✓"></input>
                       <input value=${comment.article_id} type="hidden" name="article_id" id="article_id"></input>
                       <input value=${comment.id} type="hidden" name="comment_id" id="comment_id"></input>
                       <button name="button" type="submit" class="good_btn" disabled="disabled">
                         <i class="fas fa-thumbs-up">
                           <span class="count_good">0</span>
                         </i>
                       </button>
                     </form>
                   </div>
                   <div class="comment__evaluation__form">
                     <form class="evaluation_form_bad" action="/evaluations/bad" accept-charset="UTF-8" method="post">
                       <input name="utf8" type="hidden" value="✓"></input>
                       <input value=${comment.article_id} type="hidden" name="article_id" id="article_id"></input>
                       <input value=${comment.id} type="hidden" name="comment_id" id="comment_id"></input>
                       <button name="button" type="submit" class="bad_btn" disabled="disabled">
                         <i class="fas fa-thumbs-down">
                           <span class="count_bad">0</span>
                         </i>
                       </button>
                     </form>
                   </div>
                 </div>
                </div>`
    return html;
  }

  $(document).on('click', "a[href^='#index']", function(){
    let textarea = $('.text_area')
    let Class = $(this).parent();
    let index = Class.data('index');
    let inputVal = '>>' + `${index}` +'\n';
    textarea.val(textarea.val() + inputVal);
    $('html, body').animate({
      scrollTop: $(document).height()
    },0);
    return false;

  });
  
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
      if ($.isArray(data.comment1)) {
        var insertHTML = '';
        $.each(data.comment1, function(i, comment) {
          insertHTML += buildHTML(comment);
        });
        console.log(data);
        console.log(data.comment2);
      } else {
        insertHTML = buildHTML(data);
        let anchor = data.anchor
        $.each(anchor, function(i, e) {
          $(document).ready(function() {
            let Class = $(`.comment__reply__count[data-index=${e}]`);
            let val = Class.text();
            val++;
            Class.text(val);
            let reply = $(`.comment__reply__content[data-index=${e}]`);
            reply.append(buildREPLY(data));
          });
        })

      }
      
      var comment = $('.new_comment:last');
      comment.append(insertHTML);
      comment.hide();
      comment.fadeIn(200)
      $('.text_area').val('');
      $('.submit_comment').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })


  var reloadComments = function() {
    var last_comment_id = $('.comment:last').data("comment-id");
    var article_id = $('.article__header__title').data("article-id");
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
      if ( insertHTML !== '') {
      }
    })
    .fail(function() {
      alert('error');
    });
  };
  
  if (document.location.href.match(/\/articles\/\d+\/article_comments/)) {
    //setInterval(reloadComments, 7000);
  }


  $(document).on('click','.comment__reply#hide', function() {
    var reply = $(this).find('.comment__reply__content');
    reply.fadeIn(300);
    $(this).removeAttr('id');
    $(this).attr('id', 'show');
  })
  $(document).on('click','.comment__reply#show', function(){
    var reply = $(this).find('.comment__reply__content');
    reply.fadeOut(300);
    $(this).removeAttr('id');
    $(this).attr('id', 'hide');
  });

  $("a[href^='#page-top']").on('click', function(){
    $('html, body').animate({
      scrollTop: 0
    },0);
    return false;
  });

  $("a[href^='#page-bottom']").on('click', function(){
    $('html, body').animate({
      scrollTop: $(document).height()
    },0);
    $('.text_area').focus();
    return false;
  });
});