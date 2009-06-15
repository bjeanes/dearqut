anonymous = User.find(0) || User.new
anonymous.id = 0
anonymous.save(false)

campuses = { 
  # TODO check abbreviations here
  "GP" => "Gardens Point",
  "KG" => "Kelvin Grove",
  "CA" => "Carseldine",
  "CB" => "Caboolture"
}

campuses.each_pair do |abbreviation, name|
  Campus.find_or_create_by_abbreviation(abbreviation) {|c| c.name = name}
end

faculties = [
  "Built Environment and Engineering",
  "Business",
  "Creative Industries",
  "Education",
  "Health",
  "Law",
  "Humanities",
  "QUT International College",
  "Science and Technology"
]

faculties.each do |name|
  Faculty.find_or_create_by_name(name)
end

units = %w{
  INB101 INB102 INB103 INB104 INB120 INB122 INB123 INB124 INB180 INB181 INB204 
  INB205 INB210 INB220 INB221 INB250 INB251 INB255 INB270 INB271 INB272 INB280 
  INB281 INB300 INB301 INB302 INB304 INB305 INB306 INB307 INB308 INB309-1 INB309-2 
  INB311 INB312 INB313 INB320 INB321 INB322 INB323 INB325 INB330 INB331 INB334
  INB335 INB340 INB341 INB342 INB345 INB346 INB347 INB350 INB351 INB352 INB353
  INB355 INB365 INB370 INB371 INB372 INB373 INB374 INB379 INB380 INB381 INB382
  INB385 INB386 INB830 INB860	
}

units.each do |name|
  Tag.find_or_create_by_name(name)
end