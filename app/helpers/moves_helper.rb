module MovesHelper
  def search(key, cursor, c)
    if cursor + c == key[0...cursor.length + 1]
      puts "search: #{key}, #{cursor}, #{c}"
      cursor += c
      if cursor.length == key.length
        return cursor
      end
    end
    return cursor
  end

  def search_stat(stat, c, chars)
    out = ""
    if c == stat[0].upcase
      if chars[0..(stat.length - 2)].join('') == stat.upcase[1..-1]
        out = "<span class=\"small-stat #{stat.downcase}\">#{stat.downcase}</span>"
        (stat.length - 1).times { chars.shift }
      end
    end
    return out
  end

  def search_when(c, chars, stack)
    out = ""
    if c == "W"
      if chars[0..7].join('') == "hen you "
        out = "When you <strong>"
        7.times {chars.shift}
        stack.push "strong"
      end
    end
    return out
  end

  def parsemove(body)
    result = "<p>"
    stack = ["p"]
    search_brave = ""
    chars = body.split ""
    while chars.length > 0
      c = chars.shift
      out = ""
      if c == "*"
        out = ""
        new_line = false
        while stack.size > 0
          case stack.last
          when "ul"
            stack.pop
            new_line = true
            out += "</ul>"
          when "li"
            stack.pop
            new_line = true
            out += "</li>"
          when "strong"
            stack.pop
            out += "</strong>"
          else
            break
          end
        end
        unless out == ""
          out += "<p>"
          stack.push "p"
        end
        stack.push "strong"
        if new_line
          out += "\n"
        end
        out += "<span class='star'>*</span><strong>"
      elsif c == "," && stack.size > 0 && stack.last  == "strong"
        stack.pop
        out = ",</strong>"
      elsif c == "$"
        while stack.size > 0
          out = ""
          case stack.pop
          when "p"
            out += "</p>"
          when "strong"
            out += "</strong>"
          when "ul"
            out += "</ul>"
          when "li"
            out += "</li>"
          end
        end
        out += "<p>"
        stack.push "p"
      elsif c == ">"
        while stack.size > 0
          out = ""
          new_list = true
          case stack.last
          when "p"
            stack.pop
            out += "</p>"
          when "strong"
            stack.pop
            out += "</strong>"
          when "ul"
            new_list = false
            break
          when "li"
            stack.pop
            out += "</li>"
          else
            stack.pop
          end
        end
        if new_list
          out += "<ul>"
          stack.push "ul"
        end
        out += "<li>"
        stack.push "li"
      elsif c == "["
        cc = chars.shift
        out = ""
        while cc != "]"
          out += cc
          cc = chars.shift
        end
        cc = chars.shift
        if cc == "("
          ccc = chars.shift
          stat = ""
          while ccc != ")"
            stat += ccc
            ccc = chars.shift
          end
          out = "<span class=\"move-reference #{stat}\">#{out}</span>"
        end
      else
        out += search_stat "brave", c, chars
        out += search_stat "fierce", c, chars
        out += search_stat "wary", c, chars
        out += search_stat "clever", c, chars
        out += search_stat "strange", c, chars
        out += search_stat "trust", c, chars
        out += search_when c, chars, stack
        if out == ""
          out = c
        end
      end
      result += out
    end
    return result
  end
end
