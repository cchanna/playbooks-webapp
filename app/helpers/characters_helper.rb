module CharactersHelper
	def filter_text(text)
		result = ""
		text.split("\n").each do |line|
			result += '<p>' + line + '</p>'
		end
		return result
	end
end