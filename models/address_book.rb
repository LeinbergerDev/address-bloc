require_relative 'entry'
require "csv"

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    index = 0;
    entries.each do |entry|
      if name < entry.name
        break
      end
      index+= 1
    end
    entries.insert(index, Entry.new(name, phone_number, email))
  end

  def remove_entry(name, phone_number, email)
    index = 0
    entries.each do |entry|
      if (entry.name == name && entry.phone_number == phone_number && entry.email == email)
        break
      end
      index += 1
    end
    entries.delete_at(index)
  end

  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end

  def binary_search(name)
    lower = 0
    upper = entries.length - 1
    index = 0
    while lower <= upper
      index += 1
      mid = (lower + upper) / 2
      mid_name = entries[mid].name
      if name == mid_name
        puts "it took #{index} iterations to find the entry"
        return entries[mid]
      elsif name < mid_name
        upper = mid - 1
      elsif name > mid_name
        lower = mid + 1
      end
    end
    puts "it took #{index} iterations to find that the entry doesn't exist"
    return nil
  end

  def iterative_search(name)
    index = 0
    entries.each do |entry|
      index += 1
      if entry.name == name
        puts "it took #{index} iterations to find the entry"
        return entry
      end
    end
    puts "it took #{index} iterations to find that the entry doesn't exist"
    return nil
  end

end
