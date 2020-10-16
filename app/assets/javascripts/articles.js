$(function(){
  var url = location.href;

  function addCss (e){
    e.css('background-color', 'rgb(94, 94, 94)');
  }

  if (url.match(/\/articles$/)) {
    let Class = $('.content__top__category#headLine');
    addCss(Class);
  } else {
    for (var i=0; i<=5; i++) {
      let pattern = new RegExp( "\/articles\/" + i +"$");
      let result = pattern.test(url);
      if (result === true) {
        addCss($(`.content__top__category#${i}`));
      }
    }
  }
  
});