# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

justin_bieber = Artist.create(name: 'Justin Bieber')
Song.create(name: 'Love Yourself', artist_id: justin_bieber.id)
Song.create(name: 'Baby', artist_id: justin_bieber.id)

selena_gomez = Artist.create(name: 'Selena Gomez')
Song.create(name: 'Hands To Myself', artist_id: selena_gomez.id)

Artist.create(name: 'Miley Cyrus')
