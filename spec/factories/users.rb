# coding: utf-8
# Read about factories at http://github.com/thoughtbot/factory_girl

umaumao = {
              "id" => 123456789012345,
              "name" => "uma umao",
              "first_name" => "uma",
              "last_name" => "umao",
              "link" => "http://www.facebook.com/umaumao",
              "hometown" => {"id" => "123526787720100", "name" => "福岡県朝倉市"},
              "location" => {"id" => "163173617067956", "name" => "神奈川県横浜市"},
              "bio" => "I'm a uma.",
              "quotes" => "I hate deny.",
              "work" => [
                          {"employer"=> {"id"=>"127946867218930", "name"=>"Meguro"},
                           "start_date"=>"0000-00",
                           "end_date"=>"0000-00"}
                        ],
              "education" =>  [
                                {"school"=> {"id"=>"99999999999999999", "name"=>"uma大学"},
                                 "concentration"=> [{"id"=>"176561695714928", "name"=>"競走馬学部"}],
                                 "type"=>"College"
                                },
                                {"school"=> {"id"=>"111890045496414", "name"=>"朝倉高等学校"},
                                 "type"=>"High School"}
                              ],
              "gender" => "male",
              "timezone" => 9,
              "locale" => "ja_JP",
              "languages" => [
                              {"id"=>"109549852396760", "name"=>"Japanese"},
                              {"id"=>"106059522759137", "name"=>"English"}
                             ],
              "verified" => true,
              "updated_time" => Time.new(2011,03,03)
}
umaumako = {
              "id" => 123456789012346,
              "name" => "uma umako",
              "first_name" => "uma",
              "last_name" => "umako",
              "link" => "http://www.facebook.com/umaumako",
              "hometown" => {"id" => "123526787720100", "name" => "福岡県朝倉市"},
              "location" => {"id" => "163173617067956", "name" => "神奈川県横浜市"},
              "bio" => "I'm a uma.",
              "quotes" => "I hate deny.",
              "work" => [
                          {"employer"=> {"id"=>"127946867218930", "name"=>"Meguro"},
                           "start_date"=>"0000-00",
                           "end_date"=>"0000-00"}
                        ],
              "education" =>  [
                                {"school"=> {"id"=>"99999999999999999", "name"=>"uma大学"},
                                 "concentration"=> [{"id"=>"176561695714928", "name"=>"競走馬学部"}],
                                 "type"=>"College"
                                },
                                {"school"=> {"id"=>"111890045496414", "name"=>"朝倉高等学校"},
                                 "type"=>"High School"}
                              ],
              "gender" => "male",
              "timezone" => 9,
              "locale" => "ja_JP",
              "languages" => [
                              {"id"=>"109549852396760", "name"=>"Japanese"},
                              {"id"=>"106059522759137", "name"=>"English"}
                             ],
              "verified" => true,
              "updated_time" => Time.new(2011,03,03)
}
umaumazo = {
              "id" => 123456789012347,
              "name" => "uma umazo",
              "first_name" => "uma",
              "last_name" => "umazo",
              "link" => "http://www.facebook.com/umaumako",
              "hometown" => {"id" => "123526787720100", "name" => "福岡県朝倉市"},
              "location" => {"id" => "163173617067956", "name" => "神奈川県横浜市"},
              "bio" => "I'm a uma.",
              "quotes" => "I hate deny.",
              "work" => [
                          {"employer"=> {"id"=>"127946867218930", "name"=>"Meguro"},
                           "start_date"=>"0000-00",
                           "end_date"=>"0000-00"}
                        ],
              "education" =>  [
                                {"school"=> {"id"=>"99999999999999999", "name"=>"uma大学"},
                                 "concentration"=> [{"id"=>"176561695714928", "name"=>"競走馬学部"}],
                                 "type"=>"College"
                                },
                                {"school"=> {"id"=>"111890045496414", "name"=>"朝倉高等学校"},
                                 "type"=>"High School"}
                              ],
              "gender" => "male",
              "timezone" => 9,
              "locale" => "ja_JP",
              "languages" => [
                              {"id"=>"109549852396760", "name"=>"Japanese"},
                              {"id"=>"106059522759137", "name"=>"English"}
                             ],
              "verified" => true,
              "updated_time" => Time.new(2011,03,03)
}
Factory.define :user_uma, :class => User do |u|
  u.id "4d74460c96b9613783000001"
  u.username "uma.umao"
  u.facebook_id "123456789012345"
  u.access_token "sladfalkdjfalsdjfa:dfa:wdopfjrpwejkfrelwkfmlsdmlaskdmf"
  u.facebook umaumao 
end

Factory.define :user_umako, :class => User do |u|
  u.id "4d74460c96b9613783009999"
  u.username "uma.umako"
  u.facebook_id "123456789012346"
  u.access_token "asdofjal:]adfka:wejr230edsklaxmcalsfjka"
  u.facebook umaumako
end

Factory.define :user_umazo, :class => User do |u|
  u.id "4d74460c96b9613783000002"
  u.username "uma.umazo"
  u.facebook_id "123456789012347"
  u.access_token "asdofjal:]adfka:wejr230edsklaxmcalsfjka"
  u.facebook umaumako
end
