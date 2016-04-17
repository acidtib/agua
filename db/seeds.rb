# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

locations = [
  [1, "Wynwood"],
  [2, "Miami Beach"],
  [3, "Downtown"],
  [4, "Design District"],
  [5, "Brickell"]
]

locations.each do |location|
  Location.create(id: location[0], name: location[1], slug: location[1].parameterize)
end