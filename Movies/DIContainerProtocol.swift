import Foundation

protocol DIContainerProtocol {
    var webService: WebServiceProtocol { get }
    var moviesRepository: MoviesRepositoryProtocol { get }
    var moviesWebServiceDAO: MoviesWebProtocol { get }
    var memoryStore: MemoryStore { get }
}