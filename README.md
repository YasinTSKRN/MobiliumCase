# MobiliumCase
Mobilium Case Study



Mobillium Mid iOS Developer Challenge


Summary 
In this challenge you will make a simple movie application that user search the movie, that he/she wants, browse the upcoming and now playing movies.In addition user can go to the detail page of movie. In detail page user can read the description of the movie, see what is the rate of the movie, can go to imdb page of the movie and navigate to the similar movies detail. 

Before You Start
You must use https://www.themoviedb.org api’s. Before you start you need to do correct configurations to user their api’s. 

Required Third Party Libraries
    •    Alamofire
    •    KingFisher
All libraries must be included to the project with CocoaPods

Good To Know
    •    Codable objects is plus
    •    Clean request manager is plus
    •    Architecting app with MVVM or Viper is plus


ListViewController


    •    Slider’s data should getted from “/movie/now_playing”.
    •    Other data should getted from “/movie/upcoming”.














SearchViewController

    •    Search data should getted from “/search/movie”.
    •    Search should start when user write more than two word to the search box.
    •    User can go to the detail of the movie.

















MovieDetailViewController

    •    Movie detail data should getted from “movie/{movie_id}”.
    •    Similar movies data should getted from “movie/{movie_id}\similar”.
    •    User can go to the imbd page of the movie with “imdb_id” parameter.
    •    User can go to the similar movies detail.
