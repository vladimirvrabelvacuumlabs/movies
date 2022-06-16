//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

final class MoviesScreenViewModel: ObservableObject, MoviesScreenViewModelProtocol {
    @Published var movies: [Movie] = []
    
    let moviesRepository: MoviesRepositoryProtocol
    let cancelBag = CancelBag()
    
    init(moviesRepository: MoviesRepositoryProtocol) {
        self.moviesRepository = moviesRepository
    }
    
    func loadPopularMovies() {
        moviesRepository
            .loadPopularMovies()
            .sink(receiveCompletion: { completion in
                // nothing to do now (here could be progress / error handling in future)
            }, receiveValue: { movies in
                self.movies = movies
            })
            .store(in: cancelBag)
    }
}
