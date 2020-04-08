def print_source_code
    current_file = File.basename(__FILE__)
    File.open("#{current_file}", "r") {|file| file.readlines.each{|line| puts line}}
end 

print_source_code
