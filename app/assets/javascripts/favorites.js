$(function(){
  $('.vote_btn').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action');
    let comment_id = $(this).children('#favorite_comment_id').attr('value');
    let user_id = $(this).children('#favorite_user_id').attr('val');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let vote_count = $(`.vote_count[data-comment-id=${data.comment_id}]`);
      vote_count.html(data.vote);
      $('.submit_vote').prop('disabled', false);
    })
  });
});