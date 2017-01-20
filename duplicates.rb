require 'fileutils'

FOLDER = ARGV[0]

filenames = Dir.glob(FOLDER + "/*.png")
LABELS_ID = Array.new

def duplicated(filenames_id)
  a = filenames_id.select {|e| filenames_id.count(e) > 1}.uniq
  a
end

def id_mapper(file_name)
    id = /\/([0-9]+)/.match(file_name).to_s
    id = /[0-9]+/.match(id).to_s
    LABELS_ID << id
end

filenames.each do |filename|
    id_mapper(filename)
end

duplicated = duplicated(LABELS_ID)

print "\n"
print "Duplicates: "
print duplicated
print "\n"