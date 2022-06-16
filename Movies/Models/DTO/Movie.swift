//
//  Movie.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import Foundation

struct Movie: Identifiable {
    let id: Int
    let title: String
    let genres: String
    let overview: String
    let image: Image
    let popularity: Float
}
