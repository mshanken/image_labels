require 'fileutils'

FOLDER_1 = ARGV[0]
FOLDER_2 = ARGV[1]

ID_NOT_FOUND = Array.new
FOUND = Array.new

def file_exist(cleaned, un_cleaned)
  un_cleaned.each do |filename|
      if(cleaned.include?(filename))
        FOUND << filename
      else
        ID_NOT_FOUND << filename
      end           
    end

end 


def get_id(file_name)
  
  id_to_clean = /\/([0-9]+)/.match(file_name).to_s
  id_cleaned = /[0-9]+/.match(id_to_clean).to_s
  id_cleaned

end

def just_id(directory)
  ar = Array.new  
  directory.each do |filename|
    ar << get_id(filename)
  end
  ar
end 


cleaned = Dir.glob(FOLDER_1 + "/*.png")
cleaned = just_id(cleaned)
un_cleaned = Dir.glob(FOLDER_2 + "/*.png")
un_cleaned = just_id(un_cleaned)

file_exist(cleaned, un_cleaned)

print "ID's Not Found: " + "\n"
print ID_NOT_FOUND
print "\n"
print "ID's Found: " + "\n"
print FOUND.length
print "\n"
print "Cleaned lenght: " + "\n"
print cleaned.length
print "\n"
print "Un_Cleaned lenght: " + "\n"
print un_cleaned.length
print "\n"




