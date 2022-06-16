import Combine
import Foundation
import SwiftUI

struct DIContainer: DIContainerProtocol {
    let webService: WebServiceProtocol
    let moviesRepository: MoviesRepositoryProtocol
    let moviesWebServiceDAO: MoviesWebProtocol
    let memoryStore: MemoryStore
    
    static let shared = DIContainer()
    
    private init() {
        webService = WebService()
        memoryStore = MemoryStore()
        moviesWebServiceDAO = MoviesWebServiceDAO(webService: webService)
        
        let moviesMemoryDAO = MoviesMemoryDAO(memoryStore: memoryStore)
        moviesRepository = MoviesRepository(
            moviesMemoryDAO: moviesMemoryDAO,
            moviesWebServiceDAO: moviesWebServiceDAO)
    }
}
