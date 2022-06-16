import Combine
import Foundation

final class MoviesWebServiceDAO: MoviesWebProtocol {
    fileprivate let webService: WebServiceProtocol
    
    init(webService: WebServiceProtocol) {
        self.webService = webService
    }
    
    func loadGenres() -> Future<GenresResponse, Error> {
        webService.getGenres()
    }
    
    func loadPopularMovies() -> Future<PopularMovieWebResponse, Error> {
        webService.getPopularMovies()
    }
}
