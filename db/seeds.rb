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
    case f
    when "setting.sr"
      archetype.setting_symbol = lines.shift.squish
      archetype.setting_symbol_example1 = lines.shift.squish
      archetype.setting_symbol_example2 = lines.shift.squish
      archetype.setting_symbol_example3 = lines.shift.squish
      archetype.setting_other = lines.shift.squish
      archetype.setting_other_example1 = lines.shift.squish
      archetype.setting_other_example2 = lines.shift.squish
      archetype.setting_other_example3 = lines.shift.squish
    when "sample_names.sr"
      lines.each do |l|
        l.squish!
        if l
          SampleName.create(name: l, archetype: archetype)
        end
      end
    when "looks.sr"
      lines.each do |l|
        l.squish!
        if l
          DefLook.create(look: l, archetype: archetype)
        end
      end
    when "name_categories.sr"
      lines.each do |l|
        l.squish!
        if l
          NameCategory.create(name: l, archetype: archetype)
        end
      end
    when "trust_questions.sr"
      while lines.length > 0
        question = lines.shift.squish
        trust = lines.shift.squish
        TrustQuestion.create(question: question, trust: trust, archetype: archetype)
      end
    when "tools.sr"
      def_tool = DefTool.create(name: lines.shift.squish)
      while lines.length > 0
        line = lines.shift
        if line[0] == "\t"
          ExampleTool.create(example: line.squish, def_tool: def_tool)
        else
          def_tool = DefTool.create(name: line.squish)
        end
      end
    when "stats.sr"
      while lines.length > 0
        line = lines.shift
        fields = line.strip.delete(" ").split(":")
        case fields[0]
        when "brave"
          archetype.brave = fields[1].to_i
        when "fierce"
          archetype.fierce = fields[1].to_i
        when "wary"
          archetype.wary = fields[1].to_i
        when "clever"
          archetype.clever = fields[1].to_i
        when "strange"
          archetype.strange = fields[1].to_i
        when "move_count"
          archetype.starting_move_count = fields[1].to_i
        end
      end
    when "moves.sr"
      def_move = DefMove.new(name: lines.shift.squish, archetype: archetype)
      in_body = false
      options = Array.new
      while lines.length > 0
        line = lines.shift
        if line[0] == "\t"
          if line[1] == "\t" && in_body
            def_move.body += line.squish + "\n"
          else
            fields = line.strip.delete(" ").split(":")
            case fields[0]
            when "stat"
              def_move.stat = fields[1]
              in_body = false
            when "has_description"
              def_move.has_description = fields[1] == "true"
              in_body = false
            when "free"
              def_move.free = fields[1] == "true"
              in_body = false
            when "body"
              def_move.body = ""
              in_body = true
            when "option"
              options.push fields[1].squish
              in_body = false
            when "options_selectable"
              def_move.options_selectable = fields[1].to_i
            end
          end
        1elsif line.squish.length > 0
          in_body = false
          def_move.save
          options.each do |o|
            DefMoveOption.new(def_move: def_move, option: o)
          end
          def_move = DefMove.new(name: line.squish, archetype: archetype)
        end
      end
      def_move.save
    end
  end
  archetype.save
  chdir('../')
end
chdir(current_dir)
