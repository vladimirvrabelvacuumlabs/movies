//
//  MovieDetailsScreenViewModel.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

final class MovieDetailsScreenViewModel: MovieDetailsScreenViewModelProtocol {
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
}
