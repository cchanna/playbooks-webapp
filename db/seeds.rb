# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Archetype.create(
  name: "Scoundrel",
  setting_symbol: "wealth",
  setting_symbol_example1: "a treasure-filled tomb",
  setting_symbol_example2: "the merchant's palace",
  setting_symbol_example3: "the pirate queen",
  setting_other: "someone you left behind",
  setting_other_example1: "... who wants you back",
  setting_other_example2: "... who wants you dead",
  setting_other_example3: "... who'd rather you stay gone"
)

scoundrel = Archetype.find_by(name: "Scoundrel")
Character.create(name: "Claire", archetype: scoundrel)
