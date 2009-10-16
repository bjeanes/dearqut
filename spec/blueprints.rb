require 'machinist'
require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.define do
  login { Faker::Internet.user_name.gsub(/\./,'')[0...15] }
  body  { Faker::Lorem.sentences(5).join(' ')     }
end

Message.blueprint do
  body
  user
end

Message.blueprint(:private) do
  private(true)
end

Message.blueprint(:spam) do
  user nil
  b = %|
  [url=http://drugsnoprescription.org/main.php?sid=21&q=Lexapro&said=fpost][b][u]Lexapro[/u][/b][/url]

  Without Prescription from [url=http://drugsnoprescription.org/main.php?sid=21&q=Lexapro&said=fpost][color=red] [b]Reliable Supplier of Generic Medications[/b][/color][/url]
  Fast Shipping (COD, FedEx). Next Day Delivery.
  We accept: [b]VISA, MasterCard, E-check, AMEX[/b] and more.
  To buy Lexapro, click [b]“BUY NOW”[/b] and go to the pharmacies directory or

  [url=http://drugsnoprescription.org/main.php?sid=21&q=Lexapro&said=fpost][color=blue] [b]select from the list of Lexapro pharmacies below[/b][/color][/url]

  [url=http://drugsnoprescription.org/main.php?sid=21&q=Lexapro&said=fpost][img]http://drugsnoprescription.org/thumbs/buynow.gif[/img][/url]

  [url=http://iwebimg.net/ifeed/link/804/fimg/Lexapro/1][img]http://iwebimg.net/ifeed/img/804/fimg/Lexapro/1[/img][/url]
  [url=http://iwebimg.net/ifeed/link/804/fimg/Lexapro/2][img]http://iwebimg.net/ifeed/img/804/fimg/Lexapro/2[/img][/url]
  [url=http://iwebimg.net/ifeed/link/804/fimg/Lexapro/3][img]http://iwebimg.net/ifeed/img/804/fimg/Lexapro/3[/img][/url]
  [url=http://iwebimg.net/ifeed/link/804/fimg/Lexapro/4][img]http://iwebimg.net/ifeed/img/804/fimg/Lexapro/4[/img][/url]

  [color=White]

  [b]Buy cheap lexapro.[/b]Particularly nasty, killer superbugs are appearing in Texas- border communities because of the potential slightly increased the chance of breast cancer.Where to buy lexapro.Techniques that affect activity levels, especially if you have a mammogram every year.[b]Buy lexapro medication online.[/b][url=http://www.esnips.com/user/BuyLexapro1qo] buy lexapro online [/url]
  [i]Buy lexapro cheap ndice.[/i]Sometimes the depressed people can be treated successfully through the use of a sleep specialist.[url=http://www.ilike.com/user/BuyLexapro0s] buy lexapro in canada [/url]
  Antibiotics can save patients and insurance companies thousands of dollars supposedly without sidewalks and parks.Oestrogen and progesterone are made primarily affects young adolescent girls in the Western culture, a more serious disorders.[url=http://www.ilike.com/user/BuyLexapro0s] buying lexapro online without prescription [/url]
  [b]Buy lexapro without a prescription.[/b]This extreme dieting is loss of excess body fat for human cultures, obesity is an extraordinarily hazardous statistical task, for two separate reasons.Parents and guardians should consult their doctor in the context of her health with slenderness, and makes room for more.By extension, therefore, obesity is only be sold in registered pharmacies, by or under Mental Health Initiative study to be stopped.[url=http://buylexapro_e.wackwall.com] buy lexapro in canada [/url]
  [b]Buy lexapro news.[/b]The significant research centres advising the European cultures, it often in binges.The significant research centres advising the European Union, estimated that Finland, Germany, Greece, Cyprus, the Czech Republic, Slovakia, and Malta have finished the course.[b]Buy lexapro news.[/b][url=http://www.ilike.com/user/BuyLexapro0s] buy lexapro online [/url]

  [/color]

  Related links:
  [url=http://www.ilike.com/user/CheapCarisoprodol0s] [/url]
  [url=http://www.ilike.com/user/BuyPhentermine0v]phentermine buy california [/url]
  [url=http://www.ilike.com/user/BuyFioricet0o]search php buy fioricet online [/url]
  [url=http://dotnet.org.za/members/Tramadol1c.aspx]tramadol overdose [/url]
  [url=http://www.kaboodle.com/richardreich]buy order clonazepam online no prescription [/url]|
  r1 = rand(b.length)
  r2 = rand(b.length)
  body b[[r1,r2].min, [r1,r2].max]
end

User.blueprint do
  login
  twitter_id { rand(99999) }
  password               "password"
  password_confirmation  "password"
end

User.blueprint(:protected) do
  protected(true)
end