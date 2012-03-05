# coding: utf-8
# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :error_mention001, :class => Mention do |m|
  m.venue_id nil
  m.text nil
end

Factory.define :error_mention002, :class => Mention do |m|
  m.venue_id ""
  m.text ""
end

Factory.define :mention001, :class => Mention do |m|
  m.venue_id "4bd84162e914a593bdbf52fa"
  m.text "ampm 目黒1丁目店 001"
  m.created_at Time.now.yesterday
end

Factory.define :mention002, :class => Mention do |m|
  m.venue_id "4bd84162e914a593bdbf52fa"
  m.text "ampm 目黒1丁目店 002"
end

Factory.define :mention003, :class => Mention do |m|
  m.venue_id "4b64e43ff964a520e7d72ae3"
  m.text "カレーハウス CoCo壱番屋 目黒駅西口店 001"
end
