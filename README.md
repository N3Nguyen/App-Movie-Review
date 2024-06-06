# iOS Movie Listings App

### This app uses UIViews, UITableViews, UICollectionView NavigationController and other Swift MVC features to show all the movies present in the TMDB.
### It connects with the TMDB dev API and shows the movie details with posters and pictures on the go.
----------------------------------------------------------------------------------
Some images of the application.

<img src="https://github.com/N3Nguyen/MyMovie/blob/Develop/Screen/ScreenApp.png" width="400" height="700">

### Description
 * App shows you collections of TV streaming and other movies.
 * App built using the MVC architecture.
 * This app includes descriptions for each movie as well as trailers and the movie’s rating.
 * Movie also contains movies that are from paid apps such as Netflix.
 * User can view movie details by tapping on a cell.
 * Movie details page contain backdrop and poster image, overview, duration and other relevant information.
 * It also features the best movies that refresh weekly so you can choose and watch the latest movies that have the best ratings.
----------------------------------------------------------------------------------

P.S.: You will have to:

Create a TMDB Dev Account (https://www.themoviedb.org)

Get the API Key

You can load movie data information with your API key with the following urls:

Get Now Playing : http://api.themoviedb.org/3/movie/now_playing?api_key=<<api_key>>

Get Popular : http://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>

Get Top Rated : http://api.themoviedb.org/3/movie/top_rated?api_key=<<api_key>>

Get Upcoming : http://api.themoviedb.org/3/movie/upcoming?api_key=<<api_key>>

Each movie entry has a field called “poster_path” or , which is where you should download the picture for the movies

URI: http://image.tmdb.org/t/p/<<size>>/<<poster_path>>"; // size : "w92", "w154", "w185", "w342", "w500", "w780", or "original".
