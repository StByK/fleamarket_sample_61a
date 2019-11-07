development_seed_files = Dir[ Rails.root.join('db', 'seeds', '*.rb') ].sort

ActiveRecord::Base.transaction do
  development_seed_files.each do |file|
    puts "execute #{File.basename(file)} seed"
    load(file)
  end
end

# Dir.glob(File.join(Rails.root, 'db', 'seeds', '*.rb')) do |file|
#   load(file)
# end
