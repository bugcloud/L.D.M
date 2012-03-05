require 'spec_helper'

describe ApplicationHelper do
  it "#f should be alias of String#force_encoding('utf-8')" do
    str = "a12b.-c".force_encoding('ASCII-8BIT')
    str.encoding.to_s.should == "ASCII-8BIT"
    helper.f(str).encoding.to_s.should == "UTF-8"
  end

  it "#facebook_image(id) should make facebook picture path" do
    expectString = "https://graph.facebook.com/bug/picture"
    helper.facebook_image("bug").should == expectString
  end

  it "#hbr should change linebreak -> <br/>" do
    expectString = "&lt;a<br />\nb"
    helper.hbr("<a\nb").should == expectString
  end
end
