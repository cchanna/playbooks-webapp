module ImprovementsHelper
  def text(improvement)
    if improvement.action = "add stat"
      return "Add 1 to #{improvement.value.upcase}"
    end
  end
end
