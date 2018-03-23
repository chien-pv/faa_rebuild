$(document).ready(function() {
  $('.to-choose-shedule').click(function(){
    var id = $(this).attr('data-id');
    $('.checked-' + id).prop('checked', true);
    $('tr').removeClass('checkbox-click');
    $('#checkbox-click-' + id).addClass('checkbox-click');
  });
});
