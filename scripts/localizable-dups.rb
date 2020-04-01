Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

def warn_dups(file_path)
  strings = File.readlines(file_path)
  values = []
  keys = []
  line = 0
  strings.each do |string|
    m = string.match(/\"(.*)\" \= \"(.*)\";/i)
    line += 1
    next if m.nil?

    key, value = m.captures
    if values.include? value
      puts "#{file_path}:#{line}: warning: value duplication"
    else
      values.push value
    end
     if keys.include? key
      puts "#{file_path}:#{line}: warning: key duplication"
     else
      keys.push key
     end
  end
end

file_path = ARGV[0]

warn_dups file_path
