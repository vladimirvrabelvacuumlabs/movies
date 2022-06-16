//
//  MockViewModels.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

final class MockViewModel: MoviesScreenViewModelProtocol {
    var movies: [Movie] = previewMovies
    
    func loadPopularMovies() {
        
    }
}

final class MockMovieDetailsViewModel: MovieDetailsScreenViewModelProtocol {
    var movie: Movie = previewMovies[1]
}
