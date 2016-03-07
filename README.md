---
layout: default
title: "Homework 8: Spotify Jukebox"
permalink: /homeworks/homework8/
---

# Homework 8: Spotify Jukebox
Due **March 21, 2016 11:59pm**.

The assignment is available for download [here](cis196_homework_8.zip).

## Before Starting
Be sure to review [lecture 8](//seas.upenn.edu/~cis196/lectures/lecture8.html).

## Task
In this homework assignment, you will be creating a Jukebox using data from the Spotify API. You will be able to create new artists and songs with Spotify players to listen to the music. 

Similar to the previous rails homeowrk, you can run `rails s` to test the your program. Alternatively, you can run `rails c` to run the console directly.

### Models and Migrations
You will create models form `Artist` and `Song`. These models will have basic validations upon creation. An artist should have many songs and a song should belong to an artist. For this homework, you will be writing your own migrations. The homework uses a persistent SQLite database for development purposes. You will want to use `rails g` to create migrations for the two models. `Artist` should have the attribute `name` and `Song` should have the attributes `name` and `artist_id`. Remember to `rake db:migrate` and `rake db:seed` the provided data. To delete the database at any time, run `rake db:drop`.

### Gems
`gem install bundler` if you haven’t already and run the `bundle` command. This will install all gems listed in your `Gemfile`.

### Spotify API
For this homework, we will being using the Spotify API. Spotify provides us with JSON data to access and embedded all songs and artists within its library. Before you start this assignment, familiarize yourself with the API by exploring `https://developer.spotify.com/web-api/get-track/`. When you want JSON for a specific artist, you can access this information by following the general format `https://api.spotify.com/v1/search?q=SOME+ARTIST&type=artist` where you provide the specific artist name. When you want JSON for a specific song, you can access this information by following the general format `https://api.spotify.com/v1/search?q=SOME+ARTIST+SOME+SONG&type=track` where you provide the specif artist name and song name.

### artist.rb
Artist should be instantiated by being passed a name. Artist should have validated the artist name using the Spotify API with the `in_spotify?` method. If the artist is not valid, the artist should not be created. The artist should have many songs. When an artist is destroyed, all songs belonging to the artist should be destroyed. You should be able to create an artist with an empty song field without creating a song without a name.

#### in_spotify?
`Artist` should also have a method named `valid_artist` that will check for a valid artist. An artist is valid if an artist has items in the Spotify API. You should use the artist search to check the Spotify API. To validate an artist, you will need to load the `JSON` from the provided link. For artists, use the type `artist` as the search field. You should interpolate the result of `artist_search` in the `search?q=` field of the url. Once you retrieve the proper `JSON`, you can validate an artist by checking if within the hash `artists`, `items` is empty. 

#### artist_search
`Artist` should have a method named `artist_search` that will format an artist name so that it can be used with the Spotify URI. Artist names should be formatted by inserting `+` instead of spaces.

### song.rb
`Song` should be instantiated by being passed a name. Song should validate the song name using the Spotify API and the method `in_spotify?`. If the song is not valid, a song should not be created. The song should belong to an artist. Since we want to make nested resouces for songs, songs should only be able to be created from an artist `show` page. When a song is destroyed, the artist it belongs to should not be destroyed. 

#### in_spotify?
`Song` should also have a method named `in_spotify?` that will check for a valid song. A song is valid if a song has items in the Spotify API. To validate an artist, you will need to load the `JSON` from the provided link. For songs, use the type `track` as the search field. You should interpolate the result from `song_search` in the `search?q=` field of the url. Once you retrieve the proper `JSON`, you can validate a song by checking if within the hash `tracks`, `items` is empty. 

#### song_search
`Song` should have a method named `song_search` that will format an artist name so that it can be used with the Spotify URI. Song names and artist name should be formatted by inserting `+` instead of spaces.

#### get_spotify_uri
`Song` should have a method `get_spotify_uri` that will use the return value from `song_search` and properly parse through the JSON from Spotify. You will want to get the song information by using the type track and pulling the first URI from the first item. To get the proper information, iterate through the `JSON` from `tracks` to `items` to `1` to `uri`.

### Spotify URI
Spotify players can be embedded into `erb` files by using `iframe` with specific sources. To specifically access Spotify information, you will want to use the general url: `https://embed.spotify.com/?uri=`. At the end of this link, you will want to interpolate the result of `get_spotify_uri`.

### Routes
You should make `Song` a nested resource of `Artist`. This means you should update your `routes` so that a song can be accessed only through the provided artist. Make sure you created nested routes in your `routes.rb` file. In addition, you should not be able to `update` or `edit` songs and artists. You should make this respective changes in your controllers and `routes.rb`.

### Uploading
To submit your homework, zip your `app` directory and `db` folder into a file called `files.zip`. copy and paste this command exactly since naming it anything else will not work `zip -r files.zip app`.
