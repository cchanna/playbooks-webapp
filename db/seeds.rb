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
    elsif f == "looks.sr"
      lines.each do |l|
        l.strip!
        if l
          DefLook.create(look: l, archetype: archetype)
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
    elsif f == "tools.sr"
      def_tool = DefTool.create(name: lines.shift.strip)
      while lines.length > 0
        line = lines.shift
        if line[0] == "\t"
          ExampleTool.create(example: line.strip, def_tool: def_tool)
        else
          def_tool = DefTool.create(name: line.strip)
        end
      end
    end
  end
  archetype.save
  chdir('../')
end
chdir(current_dir)
