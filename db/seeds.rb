Archetype.all.each do |a|
  a.destroy
end

Character.all.each do |a|
  a.destroy
end

current_dir = Dir.pwd
chdir "./db"
chdir "./archetypes"
Dir["*"].each do |a|
  chdir('./' + a)
  archetype = Archetype.new(name: a.capitalize)
  Dir['*'].each do |f|
    lines = IO.readlines(f)
    if f == "setting.sr"
      archetype.setting_symbol = lines.shift.strip
      archetype.setting_symbol_example1 = lines.shift.strip
      archetype.setting_symbol_example2 = lines.shift.strip
      archetype.setting_symbol_example3 = lines.shift.strip
      archetype.setting_other = lines.shift.strip
      archetype.setting_other_example1 = lines.shift.strip
      archetype.setting_other_example2 = lines.shift.strip
      archetype.setting_other_example3 = lines.shift.strip
    elsif f == "sample_names.sr"
      lines.each do |l|
        l.strip!
        if l
          SampleName.create(name: l, archetype: archetype)
        end
      end
    elsif f == "name_categories.sr"
      lines.each do |l|
        l.strip!
        if l
          NameCategory.create(name: l, archetype: archetype)
        end
      end
    elsif f == "trust_questions.sr"
      while lines.length > 0
        question = lines.shift.strip
        trust = lines.shift.strip
        TrustQuestion.create(question: question, trust: trust, archetype: archetype)
      end
    end
  end
  archetype.save
  chdir('../')
end
chdir(current_dir)
