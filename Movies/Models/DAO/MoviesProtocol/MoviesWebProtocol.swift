import Combine
import Foundation

protocol MoviesWebProtocol {
    func loadGenres() -> Future<GenresResponse, Error>
    func loadPopularMovies() -> Future<PopularMovieWebResponse, Error>
}
