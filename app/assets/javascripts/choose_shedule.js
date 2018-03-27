$(document).ready(function() {
  $('.to-choose-shedule').click(function(){
    var id = $(this).attr('data-id');
    if ($('.checked-' + id).is(":checked")){
      $('.checked-' + id).prop('checked', false);
      $('#checkbox-click-' + id).removeClass('checkbox-click');
    } else {
      $('.checked-' + id).prop('checked', true);
      $('#checkbox-click-' + id).addClass('checkbox-click');
    }
  });
});
