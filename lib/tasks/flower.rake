namespace :flower do

  desc 'import flowers'
  task import: :environment do
    path = Rails.root.join('db', 'seeds', 'flowers.csv')
    CSV.foreach(path, headers: true, col_sep: ';') do |row|
      f = Flower.new
      f.name = row['name']
      f.latin_name = row['latin_name']
      f.features = row['features']
      f.description = row['description']
      unless f.save
        puts f.errors.full_messages
      end
    end
  end

end
