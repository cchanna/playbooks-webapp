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
      puts chars[0..stat.length - 2].join('')
      if chars[0..(stat.length - 2)].join('') == stat.upcase[1..-1]
        puts "success"
        out = "<span class=\"small-stat #{stat.downcase}\">#{stat.downcase}</span>"
        (stat.length - 1).times { chars.shift }
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
        puts "*"
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
          when "star"
            stack.pop
            out += "</strong>"
          else
            break
          end
        end
        stack.push "star"
        if new_line
          out += "\n"
        end
        out += "<span class='star'>*</span><strong>"
      elsif c == "," && stack.size > 0 && stack.last  == "star"
        puts ","
        stack.pop
        out = ",</strong>"
      elsif c == ">"
        puts ">"
        while stack.size > 0
          out = ""
          new_list = true
          case stack.last
          when "p"
            puts "  /p"
            stack.pop
            out += "</p>"
          when "star"
            puts "  /star"
            stack.pop
            out += "</strong>"
          when "ul"
            puts "  /ul"
            new_list = false
            break
          when "li"
            puts "  /li"
            stack.pop
            out += "</li>"
          else
            puts "  else"
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
        puts "["
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
        if out == ""
          out = c
        end
      end
      result += out
    end
    return result
  end
end
