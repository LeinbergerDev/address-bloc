require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View All Entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - View Entry Number"
    puts "6 - Exit"
    print "Enter your selection: "

    selection = gets.to_i

    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        system "clear"
        view_entry_number
      when 6
        puts "Good-bye!"
        exit(0)
      else
        system "clear"
        puts "Sorry, this is not a valid input"
        main_menu
    end
  end

    def view_all_entries
      address_book.entries.each do |entry|
        system "clear"
        puts entry.to_s
        entry_submenu(entry)
      end
      system "clear"
      puts "End of entries"
    end

    def view_entry_number
      system "clear"
      if address_book.entries.size == 0
        puts "There are no entries to select from."
        main_menu
      end
      number = get_index
      if is_valid_index(number)
        display_entry_by_number(number)
      else
        until is_valid_index(number)
          puts "Sorry that is an invalid selection"
          number = get_index
        end
        display_entry_by_number(number)
      end
    end

    def get_index
      print"Enter entry number between 1 and #{address_book.entries.size}: "
      number = gets.chomp
      return number.to_i
    end

    def is_valid_index(number)
      if (number - 1 < address_book.entries.size && number - 1 >= 0)
        return true
      else
        return false
      end
    end

    def display_entry_by_number(number)
      system "clear"
      puts "You selected: #{number}"
      entry = address_book.entries[number - 1]
      puts entry.to_s
      entry_submenu(entry)
    end

    def create_entry
      system "clear"
      puts "New AddressBloc Entry"

      print "Name: "
      name = gets.chomp
      print "Phone Number: "
      phone = gets.chomp
      print "Email: "
      email = gets.chomp

      address_book.add_entry(name, phone, email)

      system "clear"
      puts "New entry created"
    end

    def search_entries
    end

    def read_csv
    end

    def entry_submenu(entry)
      puts "n - next entry"
      puts "d - delete entry"
      puts "e - edit this entry"
      puts "m - return to main menu"

      selection = gets.chomp

      case selection
        when "n"
        when "d"
        when "e"
        when "m"
          system "clear"
          main_menu
        else
          system "clear"
          puts "#{selection} is not a valid input"
          entry_submenu(entry)
      end
    end
end
