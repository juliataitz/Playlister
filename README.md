---
layout: default
title: "Homework 8: Spotify Jukebox"
permalink: /homeworks/homework8/
---

# Homework 8: Spotify Jukebox
Due **March 15, 2016 11:59pm**.

The assignment is available for download [here](cis196_homework_8.zip).

## Before Starting
Be sure to review [lecture 8](//seas.upenn.edu/~cis196/lectures/lecture8.html).

## Task
In this homework assignment, you will be creating a Jukebox using data from the Spotify API.  You will be able to create new artists and songs with Spotify players to listen to the music. 
Similar to the previous rails homeowrk, you can run `rails s` to test the your program. Alternatively, you can run `rails c` to run the console directly.

### artist.rb
Artist should be instantiated by being passed a name. Make reader methods for name. Artist should have validate the artist name using the Spotify API. If the artist is not valid, an error should be thrown before the artist is saved. The artist should have many songs. When an artist is destroyed, all songs belonging to the artist should be destroyed.

#### is_valid?
`Artist` should also have a method named `valid_artist` that will check for a valid artist. An artist is valid if an artist has items in the Spotify API. You should use the artist search to check the Spotify API.

### song.rb
Song should be instantiated by being passed a name. Make reader methods for name. Song should have validate the song name using the Spotify API. If the song is not valid, an error should be thrown before the artist is saved. The song should belong to an artist. A song should validate the artist name before being created. When a song is destroyed, the artist it belongs to should not be destroyed. 

#### is_valid?
`Song` should also have a method named `valid_song` that will check for a valid song. A song is valid if a song has items in the Spotify API. You should use the track search to check the Spotify API.

