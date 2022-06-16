import Alamofire
import Combine
import Foundation

struct WebService: WebServiceProtocol {
    private let baseURL = "https://api.themoviedb.org/3"
    private let popularMovies = "/movie/popular"
    private let genres = "/genre/movie/list"
    private let sessionManager: Alamofire.Session
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10.0
        sessionManager = Alamofire.Session(configuration: configuration)
    }
    
    func getGenres() -> Future<GenresResponse, Error> {
        WebRequest.request(
            url: baseURL + genres,
            method: .get,
            parameters: ["api_key": APIkey],
            sessionManager: sessionManager)
    }
    
    func getPopularMovies() -> Future<PopularMovieWebResponse, Error> {
        WebRequest.request(
            url: baseURL + popularMovies,
            method: .get,
            parameters: ["api_key": APIkey],
            sessionManager: sessionManager)
    }
}
