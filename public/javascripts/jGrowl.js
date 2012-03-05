var Growl = {
  headText: "Notification",
  bodyText: "This is the message from my site.",
  imgPath: "/images/growl/bulb.png",
  htmlTemplate: "<div class='growlArea'><div class='growlIcon'><img src='/images/growl/bulb.png'></div><div class='growlBody'><h1>Notification</h1><p>This is message from me.</p></div></div>",
  duration: 4000,
  init: function(hText, bText, path) {
      this.headText = hText;
      this.bodyText = bText;
      this.imgPath = path;
  },
  setDuration: function(ms) {
      this.duration = ms;
  },
  show: function() {
      var appendToTarget;
      var growlItself;
      var isFirst = true;
      if ($("#growlAreaWrapper").size() > 0) {
          appendToTarget = $("#growlAreaWrapper");
          isFirst = false;
      } else {
          appendToTarget = $("body");
          this.htmlTemplate = '<div id="growlAreaWrapper">' + this.htmlTemplate + '</div>';
      }
      var j = $(this.htmlTemplate);
      j.find(".growlBody h1").html(this.headText);
      j.find(".growlBody p").html(this.bodyText);
      j.find(".growlIcon img").attr('src', this.imgPath);
      j.appendTo(appendToTarget);
      if (isFirst) {
          growlItself = $("#growlAreaWrapper .growlArea:first");
      } else {
          growlItself = j;
      }
      growlItself.css('opacity', 1);
      setTimeout(function() {
          growlItself.css('opacity', 0)
          setTimeout(function() {
              var removeTarget = ($(".growlArea").size() > 1)? growlItself : $("#growlAreaWrapper");
              removeTarget.remove();
          }, 1000);
      }, this.duration);
  }
}
