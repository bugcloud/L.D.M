$(function() {
    var growl = object(Growl)
    growl.bodyText = "You can add spot unless we know the spot where you are."
    growl.show()

    var ll = $("#currentLL").val()
    $("#addNewSpot").bind('click', function() {
        $("body").append("<div id='overlayWrapper'>&nbsp;</div>")
        $("#overlayWrapper").fadeIn('slow', function() {
            $(this).load('/venue/new?ll='+ll)
        })
    })
})
