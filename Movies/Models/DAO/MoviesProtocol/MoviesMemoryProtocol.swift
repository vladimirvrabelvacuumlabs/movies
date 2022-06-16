import Combine
import Foundation

protocol MoviesMemoryProtocol {
    func loadPopularMovies() -> Future<[Movie], Error>
    func savePopularMovies(movies: [Movie])
    func saveGenres(genres: [Genre])
}