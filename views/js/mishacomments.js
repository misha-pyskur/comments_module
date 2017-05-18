$(document).ready(function() {
   if ($("#mishacomments_block_heading").attr("data-scroll") == "true") {
       $.scrollTo($("#mishacomments_block_heading"), 1200);
   }


    $(".grade_disabled").rating({displayOnly: true});
   $("#grade_active").rating({min:0, max:5, step:1, size:'sm'});
});
