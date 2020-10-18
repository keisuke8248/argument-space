$(function(){

  function buildHTML(data, Class1, Class2, value){
    let comment = $(`.comment[data-comment-id=${data.comment_id}]`).not('#reply');
    let form = comment.find(`.evaluation_form_${Class1}`).first();
    
    if (value === "good") {
      var UpDown = "up";
    } else {
      var UpDown = "down";
    }


    let insertHTML = buildHTML2(data.article_id,
                                data.comment_id,
                                `${Class2}_btn`,
                                value,
                                UpDown,
                                data.sum);

    form.html(insertHTML);
    
    form.attr('action', `/evaluations/${Class2}`);
    form.removeClass().addClass(`evaluation_form_${Class2}`);

    if (Class1 === "good") {
      var btn = comment.find('.bad_btn').first();
      btn.prop('disabled', true);
    }
    if (Class1  === "bad") {
      var btn = comment.find('.good_btn').first();
      btn.prop('disabled', true);
    }
    if (Class1 === "canceling_good") {
      var btn = comment.find('.bad_btn').first();
      btn.prop('disabled', false);
    }
    if (Class1 === "canceling_bad") {
      var btn = comment.find('.good_btn').first();
      btn.prop('disabled', false);
    }
  }

  function buildHTML2(article_id, comment_id, Class, value, UpDown, sum) {
    let html = `
               <input name="utf8" type="hidden" value="✓"></input>
               <input value="${article_id}" type="hidden" name="article_id" id="article_id"></input>
               <input value="${comment_id}" type="hidden" name="comment_id" id="comment_id"></input>
               <button name="button" type="submit" class=${Class}>
                 <i class="fas fa-thumbs-${UpDown}">
                   <span class="count_${value}">${sum}</span>
                 </i>
              </button>
              `
    return html;
  }

  $(document).on('submit','.evaluation_form_good', function(e){
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
    .done(function(data) {
      buildHTML(data, "good", "canceling_good", "good");
    })
    .fail(function() {
      console.log('error');
    })
  });

  $(document).on('submit', '.evaluation_form_canceling_good', function(e){
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
      buildHTML(data, "canceling_good", "good", "good");
    })
  });

  $(document).on('submit','.evaluation_form_bad', function(e){
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
    .done(function(data) {
      buildHTML(data, "bad", "canceling_bad", "bad");
    })
    .fail(function() {
      console.log('error');
    })
  });

  $(document).on('submit','.evaluation_form_canceling_bad', function(e){
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
    .done(function(data) {
      buildHTML(data, "canceling_bad", "bad", "bad");
    })
    .fail(function() {
      console.log('error');
    })
  });
});