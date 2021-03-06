time_zones = {"Hobart"=>36000, "Cape Verde Is"=>3600, "Indiana (East"=>18000, "Bratislava"=>3600, "Pacific Time (US & Canada)"=>28800, "Adelaide"=>34200, "Greenland"=>10800, "Marshall Is"=>43200, "Budapest"=>3600, "Rangoon"=>23400, "Minsk"=>7200, "Islamabad"=>18000, "Atlantic Time (Canada)"=>14400, "Volgograd"=>10800, "Riyadh"=>10800, "West Central Africa"=>3600, "Jakarta"=>25200, "Eastern Time (US & Canada)"=>18000, "Vladivostok"=>36000, "Ljubljana"=>3600, "Casablanca"=>0, "Midway Island"=>39600, "Prague"=>3600, "Hong Kong"=>28800, "Darwin"=>34200, "Rome"=>3600, "Bucharest"=>7200, "Nairobi"=>10800, "Ulaan Bataar"=>28800, "Kabul"=>16200, "Yerevan"=>14400, "Mid-Atlantic"=>7200, "Tashkent"=>18000, "Taipei"=>28800, "Dhaka"=>21600, "Chongqing"=>28800, "Moscow"=>10800, "Mexico City"=>21600, "Fiji"=>43200, "Central Time (US & Canada)"=>21600, "Krasnoyarsk"=>25200, "Paris"=>3600, "Alaska"=>32400, "Belgrade"=>3600, "Brasilia"=>10800, "Cairo"=>7200, "Auckland"=>43200, "Kuala Lumpur"=>28800, "Monrovia"=>0, "Berlin"=>3600, "Skopje"=>3600, "Warsaw"=>3600, "Edinburgh"=>0, "Amsterdam"=>3600, "Karachi"=>18000, "Guadalajara"=>21600, "Mumbai"=>19800, "Hanoi"=>25200, "Athens"=>7200, "Singapore"=>28800, "Stockholm"=>3600, "Baghdad"=>10800, "Pretoria"=>7200, "Saskatchewan"=>21600, "Istanbul"=>7200, "Buenos Aires"=>10800, "Osaka"=>32400, "Ekaterinburg"=>18000, "Chihuahua"=>25200, "Georgetown"=>10800, "Arizona"=>25200, "Monterrey"=>21600, "Baku"=>14400, "Yakutsk"=>32400, "Novosibirsk"=>21600, "Guam"=>36000, "Jerusalem"=>7200, "Kuwait"=>10800, "Helsinki"=>7200, "NULL"=>0, "Lisbon"=>0, "New Delhi"=>19800, "Sarajevo"=>3600, "Solomon Is"=>39600, "Sofia"=>7200, "Brussels"=>3600, "New Caledonia"=>39600, "Kamchatka"=>43200, "Tokyo"=>32400, "Beijing"=>28800, "Tallinn"=>7200, "Irkutsk"=>28800, "Sri Jayawardenepura"=>21600, "Canberra"=>36000, "Kolkata"=>19800, "Santiago"=>14400, "Sydney"=>36000, "Quito"=>18000, "Melbourne"=>36000, "Zagreb"=>3600, "Riga"=>7200, "Bogota"=>18000, "Kathmandu"=>20700, "Vienna"=>3600, "Vilnius"=>7200, "La Paz"=>14400, "Madrid"=>3600, "Mazatlan"=>25200, "Hawaii"=>36000, "Chennai"=>19800, "Tehran"=>12600, "Magadan"=>39600, "Wellington"=>43200, "Seoul"=>32400, "Copenhagen"=>3600, "Dublin"=>0, "Muscat"=>14400, "Tijuana"=>28800, "Kyiv"=>7200, "Newfoundland"=>12600, "Azores"=>3600, "Lima"=>18000, "Brisbane"=>36000, "London"=>0, "Central America"=>21600, "Sapporo"=>32400, "Harare"=>7200, "Perth"=>28800, "Mountain Time (US & Canada)"=>25200, "Almaty"=>21600, "Nuku'alofa"=>46800, "Bangkok"=>25200, "Abu Dhabi"=>14400, "International Date Line West"=>39600, "St. Petersburg"=>10800, "Tbilisi"=>14400, "Bern"=>3600, "Caracas"=>16200}
User.fix {{
  :dataset_id => Dataset.pick.id,
  :twitter_id => rand(2**64)+2*48,
  :screen_name => /\w+/.gen[5..25],
  :name => "#{/\w+/.gen[5..25]} #{/\w+/.gen[5..25]}",
  :location => /\w+/.gen[5..25],
  :description => /\w+/.gen[5..160],
  :profile_image_url => "http://#{/\w+/.gen}.#{/\w{3}/.gen}",
  :protected => [true,false][rand(2)],
  :followers_count => rand(50000),
  :profile_background_color => rand(16777215).to_s(16).upcase,
  :profile_text_color => rand(16777215).to_s(16).upcase,
  :profile_link_color => rand(16777215).to_s(16).upcase,
  :profile_sidebar_fill_color => rand(16777215).to_s(16).upcase,
  :profile_sidebar_border_color => rand(16777215).to_s(16).upcase,
  :friends_count => rand(50000),
  :created_at => Time.now-rand(100).days,
  :favourites_count => rand(50000),
  :time_zone => tz = time_zones.keys.shuffle.first,
  :utc_offset => time_zones[tz],
  :profile_background_image_url => "http://#{/\w+/.gen}.#{/\w{3}/.gen}",
  :profile_background_tile => [true,false][rand(2)],
  :profile_use_background_image => [true,false][rand(2)],
  :show_all_inline_media => [true,false][rand(2)],
  :is_translator => [true,false][rand(2)],
  :notifications => [true,false][rand(2)],
  :geo_enabled => [true,false][rand(2)],
  :verified => [true,false][rand(2)],
  :following => [true,false][rand(2)],
  :statuses_count => rand(50000),
  :contributors_enabled => [true,false][rand(2)],
  :lang => %(en ja fr kr es ru de)[rand(7)],
  :listed_count => rand(50000),
  :follow_request_sent => [true,false][rand(2)],
}}