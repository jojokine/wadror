b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

lager = Style.new(name:"Lager")
b1.beers.create name:"Iso 3", style:lager
b1.beers.create name:"Karhu", style:lager
b1.beers.create name:"Tuplahumala", style:lager
b2.beers.create name:"Huvila Pale Ale", style:Style.new(name:"Pale Ale")
b2.beers.create name:"X Porter", style:Style.new(name:"Porter")
b3.beers.create name:"Hefezeizen", style:Style.new(name:"Weizen")
b3.beers.create name:"Helles", style:lager