class DefDireFate < ActiveRecord::Base
  belongs_to :archetype
  has_many :dire_fates, dependent: :destroy

  def self.seed
    current_dir = Dir.pwd
    puts Dir.pwd
    Dir.chdir "./db/archetypes"
    Dir["*"].each do |a|
      puts a
      Dir.chdir('./' + a)
      archetype = Archetype.find_by(name: a.capitalize)
      if Dir["dire_fates.sr"].count > 0
        DefDireFate.where(archetype: archetype).update_all(order: nil)
        lines = IO.readlines("dire_fates.sr")
        order = 1
        peril = 1
        while lines.length > 0
          line = lines.shift.squish
          if line.length > 0
            dire_fate = DefDireFate.find_by(
              archetype: archetype,
              text: line,
              order: nil
            )
            if dire_fate
              dire_fate.update(
                peril: peril,
                order: order
              )
              # Character.where(archetype: archetype).each do |c|
              #   unless DireFate.exists?(def_dire_fate: dire_fate, character: c)
              #     DireFate.create(
              #       def_dire_fate: dire_fate,
              #       character: c
              #     )
              #   end
              # end
            else
              dire_fate = DefDireFate.create(
                archetype: archetype,
                text: line,
                peril: peril,
                order: order
              )
              Character.where(archetype: archetype).each do |c|
                DireFate.create(
                  def_dire_fate: dire_fate,
                  character: c
                )
              end
            end
            order += 1
          else
            peril += 1
            order = 1
          end
        end
        DefDireFate.where(order: nil).delete_all
      end
      Dir.chdir('../')
    end
    Dir.chdir(current_dir)
  end
end
