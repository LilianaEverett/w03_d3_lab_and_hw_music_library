require('pry-byebug')
require_relative('./models/artist')
require_relative('./models/album')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({"name" => "David Bowie"})
artist2 = Artist.new({"name" => "Anna Vanosi"})
artist1.save()
artist2.save()

album1 = Album.new({
  "name" => "Blackstar",
  "genre" => "Rock",
  "artist_id" => artist1.id
  })

  album2 = Album.new({
    "name" => "Alladin Sane",
    "genre" => "Rock",
    "artist_id" => artist1.id
    })

album1.save()
album2.save()

artist1.name = "Bowie"
artist1.update

album1.genre = "blues"
album1.update

artist2.delete

binding.pry
nil
