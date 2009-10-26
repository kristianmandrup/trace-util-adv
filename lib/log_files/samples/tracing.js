$(document).ready(function(){
  elems = $('.collapsed');
  console.log(elems)
  elems.hide();
  
  elems = $('.method-title').click(function() {	
	$(this).next().toggle();
  })
});