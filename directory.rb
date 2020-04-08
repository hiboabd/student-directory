require 'csv'
@students = []

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list of students"
    puts "4. Load the list from students.csv"
    puts "9. Exit"
end 

def interactive_menu
    loop do
        print_menu
        process(STDIN.gets.chomp)
    end 
end

def process(selection)
    case selection
    when "1"
        input_students
    when "2"
        show_students
    when "3"
        save_students
    when "4"
        load_students
    when "9"
        exit # this will cause the program to terminate
    else
        puts "I don't know what you meant, try again"
    end 
end 

def input_students
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    name = STDIN.gets.chomp # get the first name
    while !name.empty? do # while the name is not empty, repeat this code
        # add the student hash to the array
        @students << {name: name, cohort: :november}
        puts "Now we have #{@students.count} students"
        # get another name from the user 
        name = STDIN.gets.chomp
    end 
    puts "Inputting students action successful"
end 

def show_students
    print_header
    print_students_list
    print_footer
    puts "Showing students action successful"
end 

def print_header
    puts "The students of Villains Academy"
    puts "------------"
end 

def print_students_list
     @students.each do |student| 
        puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end 
end 

def print_footer
    puts "Overall we have #{@students.count} great students"
end 

def save_students
    puts "What would you like to name the file?"
    filename = gets.chomp
    CSV.open("#{filename}.csv", "wb") do |csv|
        @students.each do |hash|
            csv << hash.values
        end 
    end 
    puts "Saving students to #{filename} successful."
end

def load_students(filename = "students.csv")
    CSV.foreach("#{filename}") do |row|
        @students << {name: row[0], cohort: row[1].to_sym}
    end
end 

def start_load_students
    filename = ARGV.first # first argument from the command line
    if filename.nil?
        load_students()
        puts "Student data loaded from students.csv by default"
    elsif File.exists?(filename) # if it exists
        load_students(filename)
        puts "Loaded #{@students.count} from #{filename}"
    else #if it doesn't exist
        puts "Sorry, #{filename} doesn't exist."
        exit # quit the program
    end
end 

# method call
start_load_students
interactive_menu