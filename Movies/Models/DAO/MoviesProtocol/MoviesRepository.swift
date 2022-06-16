import Combine
import Foundation

final class MoviesRepository: MoviesRepositoryProtocol {
    let moviesWebServiceDAO: MoviesWebProtocol
    let moviesMemoryDAO: MoviesMemoryProtocol
    let cancelBag = CancelBag()
    
    init (moviesMemoryDAO: MoviesMemoryProtocol, moviesWebServiceDAO: MoviesWebProtocol) {
        self.moviesMemoryDAO = moviesMemoryDAO
        self.moviesWebServiceDAO = moviesWebServiceDAO
    }
    
    func loadPopularMovies() -> Combine.Future<[Movie], Error> {
        Future { [weak self] promise in
            guard let self = self else { return }

            // [genre] is saved in memory store, so here could be some kind of smart logic, which do not fire get genres everytime
            let genresPublisher = self.moviesWebServiceDAO.loadGenres()
            let popularMoviesPublisher = self.moviesWebServiceDAO.loadPopularMovies()
            
            genresPublisher.combineLatest(popularMoviesPublisher)
                .map { genres, popularMovies in
                    let movies = popularMovies.results.map { movie in
                        movie.mapToMovie(genres: genres.genres)
                    }
                    
                    self.moviesMemoryDAO.savePopularMovies(movies: movies)
                    self.moviesMemoryDAO.saveGenres(genres: genres.genres)

                    return (genres.genres, movies)
                }
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        promise(.failure(error))
                    }
                }, receiveValue: { (genres: [Genre], popularMovies) in
                    promise(.success(popularMovies))
                })
                .store(in: self.cancelBag)
        }
    }
}
