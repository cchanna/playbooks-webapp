module ImprovementsHelper
  def text(improvement)
    case improvement.action
    when "add stat"
      return "Add 1 to #{improvement.value.upcase}"
    when "move"
      case improvement.value
      when "self"
        return "Choose another #{@character.archetype.name} move"
      when "other"
        return "Choose a move from another archetype"
      end
    end
  end
end
