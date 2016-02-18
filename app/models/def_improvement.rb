class DefImprovement < ActiveRecord::Base
  belongs_to :archetype

  def self.seed
    current_dir = Dir.pwd
    puts Dir.pwd
    Dir.chdir "./db/archetypes"
    Dir["*"].each do |a|
      puts a
      Dir.chdir('./' + a)
      archetype = Archetype.find_by(name: a.capitalize)
      if Dir["improvements.sr"].count > 0
        DefImprovement.where(archetype: archetype).update_all(order: nil)
        lines = IO.readlines("improvements.sr")
        order = 1
        while lines.length > 0
          line = lines.shift
          if line.length > 0
            fields = line.split ":"
            action = fields[0].squish
            value = fields[1] ? fields[1].squish : nil
            improvement = DefImprovement.find_by(
              archetype: archetype,
              action: action,
              value: value,
              order: nil
            )
            if improvement
              improvement.update(
                order: order
              )
            else
              DefImprovement.create(
                archetype: archetype,
                action: fields[0].squish,
                value: fields[1] ? fields[1].squish : nil,
                order: order
              )
            end
            order += 1
          end
        end
        DefImprovement.where(order: nil).delete_all
      end
      Dir.chdir('../')
    end
    Dir.chdir(current_dir)
  end
end
