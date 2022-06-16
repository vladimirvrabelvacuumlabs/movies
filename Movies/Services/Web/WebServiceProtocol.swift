import Combine
import Foundation

protocol WebServiceProtocol {
    func getGenres() -> Future<GenresResponse, Error>
    
    // themoviedb api supports pagination for popular movies, but it is omitted for purpose of this
    // assignment. See https://developers.themoviedb.org/3/movies/get-popular-movies
    func getPopularMovies() -> Future<PopularMovieWebResponse, Error>
}
