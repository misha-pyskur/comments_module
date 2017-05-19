$(document).ready(function() {
   if ($("#mishacomments_block_heading").attr("data-scroll") == "true") {
       $.scrollTo($("#mishacomments_block_heading"), 1200);
   }


    $(".grade").rating({displayOnly: true, size: 'sm'});
   $("#grade_field").rating({min:0, max:5, step:1, size:'sm'});
});
