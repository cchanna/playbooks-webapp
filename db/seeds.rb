# upload the base moves

file = File.new(Rails.root + 'app/assets/moves.txt', 'r').read
moves = file.split("\n\n")
moves.each do |move|
  lines = move.split("\n")
  name = lines.shift
  archetype = lines.shift
  stat = lines.shift
  text = ""
  options = ""
  has_description = false
  list = false
  lines.each do |line|
    line.gsub!(/BRAVE/, '<stat- class="brave">BRAVE</stat->')
    line.gsub!(/FIERCE/, '<stat- class="fierce">FIERCE</stat->')
    line.gsub!(/WARY/, '<stat- class="wary">WARY</stat->')
    line.gsub!(/CLEVER/, '<stat- class="clever">CLEVER</stat->')
    line.gsub!(/STRANGE/, '<stat- class="strange">STRANGE</stat->')

    line.gsub!(/(\#.*?\#)/) {|s| '<strong>' + s[1..-2] + '</strong>'}
    line.gsub!(/\*.*?,/) {|s| '<result->' + s[1..-1] + '</result->'}

    line.gsub!(/\/\/.*?\/\//) {|s| '<em>' + s[2..-3] + '</em>'}
    line.gsub!(/\/B\/.*?\/B\//) {|s| '<em class="brave">' + s[3..-4] + '</em>'}
    line.gsub!(/\/F\/.*?\/F\//) {|s| '<em class="fierce">' + s[3..-4] + '</em>'}
    line.gsub!(/\/W\/.*?\/W\//) {|s| '<em class="wary">' + s[3..-4] + '</em>'}
    line.gsub!(/\/C\/.*?\/C\//) {|s| '<em class="clever">' + s[3..-4] + '</em>'}
    line.gsub!(/\/S\/.*?\/S\//) {|s| '<em class="strange">' + s[3..-4] + '</em>'}

    
    if line[0] == ">" then
      if list == false then
        text += '<ul>'
        list = true
      end
      text += '<li>' + line[1..-1] + '</li>'
    else
      if list == true then
        text += '</ul>'
        list = false
      end
      if line[0] == "@" then
        options += line[1..-1]
      elsif line[0] == "&" then
        has_description = true
      else
        text += '<p>' + line + '</p>'
      end
    end
  end
  DatabaseMove.create!(
    name: name,
    archetype: archetype,
    stat: stat,
    text: text,
    options: options,
    has_description?: has_description
  )
end



# Users
User.create!(name:  "Cerisa",
             email: "cerisa@strangerelics.com",
             password:              "password",
             password_confirmation: "password",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

# Characters
Character.create!(
  user_id: 1,
  name: "Claire",
  slug: "claire",
  archetype: "Ally",
  goal: "the World-Tree",
  motive: "protect Saanvi",
  brave: 1,
  fierce: -1,
  wary: 1,
  clever: 0,
  strange: 2,
  experience: 2,
  posessions: "An old flute, passed down from my mother\nA handful of coins",
  losses: "My family",
  pride: false,
  health: true,
  strength: false,
  hope: false,
  life: false,
  return_brave: false,
  return_strange: true,
  return_different: false,
  dead: false,
  unprepared: true,
  notes: "Nobody too special",
  look: "Meek", 
  virtue_noble: true,
  virtue_unassuming: true,
  virtue_weird: true,
  virtue_weird_description: "I can hear the spirits of the world whispering to me")

# Moves
Move.create!(
  character_id: 1,
  database_move_id: 5,
  description: "I can call upon the spirits of the world to aid me with their magic",
)

Fate.create!(
  character_id: 1,
  name: "Aya",
  value: 3
)

Fate.create!(
  character_id: 1,
  name: "Yuki",
  value: 1
)