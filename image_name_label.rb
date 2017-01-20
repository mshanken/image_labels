require 'csv'
require 'fileutils'

FOLDER = ARGV[0]
record_ids = ARGV[1]

if !(FOLDER && record_ids)
  print "You have to specify the directory of the images and the name of the record_id file " + "\n"
  exit(1)
end

def name_refactor(file_name)
  file_name_downcase = file_name.downcase

  nyc_id = id_mapper(file_name)
  to_change_file_name = File.basename(file_name, File.extname(file_name))
  new_file_name = nil

  if (nyc_id.start_with?("4"))

    if (file_name_downcase.include?("back"))

      new_file_name = nyc_id + "_back" + File.extname(file_name)
      File.rename(file_name, new_file_name)

    elsif (file_name_downcase.include?("neck"))

      new_file_name = nyc_id + "_neck" + File.extname(file_name)
      File.rename(file_name, new_file_name)

    else

      new_file_name = nyc_id + "_label" + File.extname(file_name)
      File.rename(file_name, new_file_name)

    end

    copy_with_path(new_file_name,  FOLDER + "/ny")

  else
    copy_with_path(file_name,  FOLDER + "/ca")
  end

end  

def id_mapper(file_name)
  id = /\/([0-9]+)/.match(file_name).to_s
  id = /[0-9]+/.match(id).to_s
  id_mapped = id

  if (RECORD_IDS.key?(id))
    id_mapped = RECORD_IDS[id]
  else
    if (!id.start_with?("4")) 
      ID_NOT_FOUND << id
    end  
  end
  id_mapped
end

def copy_with_path(file_name, destination)
  #FileUtils.mkdir_p(File.dirname(dst))
  FileUtils.mv(file_name, destination)
end

#return nil unless record_ids
FileUtils::mkdir_p FOLDER + '/ny'
FileUtils::mkdir_p FOLDER + '/ca'
RECORD_IDS = CSV.read(record_ids).to_h
ID_NOT_FOUND = Array.new

filenames = Dir.glob(FOLDER + "/*.png")

filenames.each do |filename|
  name_refactor(filename)
end

print "ID's Not Found: " + "\n"
print ID_NOT_FOUND
print "\n"
print "ID's Not Found Count: " + "\n"
print ID_NOT_FOUND.length
print "\n"
     
