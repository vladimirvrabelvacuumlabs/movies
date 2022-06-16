import Combine
import Foundation

protocol MoviesRepositoryProtocol {
    var moviesWebServiceDAO: MoviesWebProtocol { get }
    var moviesMemoryDAO: MoviesMemoryProtocol { get }

    func loadPopularMovies() -> Future<[Movie], Error>
}