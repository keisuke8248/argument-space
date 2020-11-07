$(function(){
  function buildHTML(comment, key){
      let html = `<div class="comment" data-comment-id=${comment.id}>
                      <div class="comment__detail">
                        <div class="comment__index" data-index="${comment.index}">
                          <a class="indexLink" href="#index">
                          ${comment.index}:
                          </a>
                        </div>
                        <a class="comment__detail__nickname" href="/users/${comment.user_id}">
                          ${comment.nickname}
                        </a>
                        <div class="comment__detail__date">
                          ${comment.date}
                        </div>
                      </div>
                      <div class="comment__text reply">
                        ${comment.text}
                      </div>
                      <div class="comment__evaluation">
                        <div class="comment__evaluation__form">
                          <form class="evaluation_form_good" action="/evaluations/good" accept-charset="UTF-8" method="post">
                            <input name="utf8" type="hidden" value="✓"></input>
                            <input value=${comment.id} type="hidden" name="comment_id" id="comment_id"></input>
                            <button name="button" type="submit" class="good_btn" ${key}>
                              <i class="fas fa-thumbs-up">
                                <span class="count_good">0</span>
                              </i>
                            </button>
                          </form>
                        </div>
                        <div class="comment__evaluation__form">
                          <form class="evaluation_form_bad" action="/evaluations/bad" accept-charset="UTF-8" method="post">
                            <input name="utf8" type="hidden" value="✓"></input>
                            <input value=${comment.id} type="hidden" name="comment_id" id="comment_id"></input>
                            <button name="button" type="submit" class="bad_btn" ${key}>
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
                      <div class="comment__reply__content" data-index=${comment.index}></div>
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
                   <a class="comment__detail__nickname" href="/users/${comment.user_id}">
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
  
  function addLinkToIndex(e) {
    var str;
    e.each(function(i, obj) {
      let text = $(obj).text();
      let anchor = text.match(/>>\d+/g);
      $.each(anchor, function(i, anchor) {
        let index = anchor.replace('>>', '');
        let comment = $(`.comment__index[data-index=${index}]`);
        let comment_id = comment.parent().parent().data("comment-id");
        if (comment_id === undefined) {
          str = text.replace(`${anchor}`, function(){
            return `<a href=/articles/1/article_comments/#>${anchor}</a>`;
            });
        } else if( i === 0 ){
          str = text.replace(`${anchor}`, function(){
            return `<a href=/articles/1/article_comments/${comment_id}>${anchor}</a>`;
            });
        } else {
          str = str.replace(`${anchor}`, function(){
          return `<a href=/articles/1/article_comments/${comment_id}>${anchor}</a>`;
          });
        }
      });
      if (anchor !== null) {
        $(obj).html(str);
      }
    });
  };

  addLinkToIndex($('.comment__text'));

  function appendReply(index, data) {
    let obj = $(`.comment__reply__count[data-index=${index}]`);
    let val = obj.text();
    val++;
    obj.text(val);
    obj.parent().css('opacity', '.2').animate({'opacity': '1'}, 'slow');
    let reply = $(`.comment__reply__content[data-index=${index}]`);
    reply.append(buildREPLY(data));
  };

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

  function hideObj(obj) {
    setTimeout(function(){
      obj.fadeOut(1000);
    }, 4000);
  }

  function alertReplies(data) {
    if (!(data === 0 || data === null)) {
      let obj1 = $('.alertReplies');
      let obj2 = $('.alertReplies__content__count');
      obj2.html(data);
      obj1.fadeIn(100, hideObj(obj1));
    }
  };

  
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
      let anchors = data.anchors;
      let key = data.userDistinction.key
      if ($.isArray(data.comment)) {
        var insertHTML = '';
        $.each(data.comment, function(i, c) {
          insertHTML += buildHTML(c, key);
          $.each(anchors[i].anchor, function(i, anchor) {
            $(document).ready(function() {
              appendReply(anchor, c);
            });
          })
        });

      } else {
        insertHTML = buildHTML(data.comment, key);
        $.each(anchors, function(i, e) {
          $(document).ready(function() {
            appendReply(e.anchor, data.comment);
          });
        })
      }
      
      let comment = $('.new_comment:last');
      comment.append(insertHTML);
      let commentText = comment.find('.comment__text');
      addLinkToIndex(commentText);
      comment.hide();
      comment.fadeIn(200);
      $('.text_area').val('');
      $('.submit_comment').prop('disabled', false);
      let reply = data.reply.reply;
      alertReplies(reply);
    })
    .fail(function(){
      alert('error');
    })
  })

  var reloadComments = function() {
    let last_comment_id = $('.comment:last').data("comment-id");
    let article_id = $('.article__header__title').data("article-id");
    $.ajax({
      url: "/articles/" + article_id + "/article_comments/api",
      type: 'get',
      dataType: 'json',
      data: {last_comment_id: last_comment_id}
    })
    .done(function(data) {
      let key = data.userDistinction.key
      var insertHTML = '';
      $.each(data.comment, function(i, comment) {
        insertHTML += buildHTML(comment, key);
      })

      let comment = $('.new_comment:last');
      comment.append(insertHTML);

      let anchors = data.anchors;
      $.each(data.comment, function(i, comment) {
        $.each(anchors[i].anchor, function(i, e) {
          $(document).ready(function() {
            appendReply(e, comment);
          });
        })
      });

      let commentText = comment.find('.comment__text');
      addLinkToIndex(commentText);
      comment.hide();
      comment.fadeIn(200);

      let reply = data.reply.reply;
      alertReplies(reply);
    })
    .fail(function() {
      alert('error');
    });
  };
  
  if (document.location.href.match(
    /\/articles\/\d+\/article_comments(?!\/\d+)/ 
    || /\/articles\/\d+\/article_comments\/index10/)
    ) {
    setInterval(reloadComments, 7000);
    var flg_load = window.performance.navigation.type;
    $(window).on('pageshow', function(){
      if( flg_load == 2 ) location.reload();
      flg_load = 2;
    });
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