campuses = { 
  # TODO check abbreviations here
  "GP" => "Gardens Proint",
  "KG" => "Kelvin Grove",
  "CA" => "Carseldine",
  "CB" => "Caboolture"
}

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

campuses.each_pair do |abbreviation, name|
  Campus.find_or_create_by_abbreviation(abbreviation) {|c| c.name = name}
end

faculties.each do |name|
  Faculty.find_or_create_by_name(name)
end