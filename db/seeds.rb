# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

archetypes = ["Hero", "Ally", "Scoundrel", "Witch", "Warrior"]
archetypes.each do |name|
  Archetype.create(name: name)
end

scoundrel = Archetype.find_by(name: "Scoundrel")
Character.create(name: "Claire", archetype: scoundrel)
