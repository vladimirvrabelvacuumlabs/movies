import Combine
import Foundation

final class MoviesMemoryDAO: MoviesMemoryProtocol {
    let memoryStore: MemoryStore
    let cancelBag = CancelBag()

    init(memoryStore: MemoryStore) {
        self.memoryStore = memoryStore
    }
    
    func loadPopularMovies() -> Future<[Movie], Error> {
        Future { [weak self] promise in
            guard let self = self else { return }

            self.memoryStore.popularMovies.sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    promise(.failure(error))
                }
            }, receiveValue: { movies in
                promise(.success(movies))
            })
            .store(in: self.cancelBag)
        }
    }
    
    func savePopularMovies(movies: [Movie]) {
        memoryStore.popularMovies.send(movies)
    }

    func saveGenres(genres: [Genre]) {
        memoryStore.genres.send(genres)
    }
}
