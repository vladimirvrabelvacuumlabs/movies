//
//  ContentView.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import SwiftUI

protocol MoviesScreenViewModelProtocol: ObservableObject {
    var movies: [Movie] { get }
    
    func loadPopularMovies()
}

struct MoviesScreen<ViewModel: MoviesScreenViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    let cancelBag = CancelBag()
    let diContainer: DIContainerProtocol
    
    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
                NavigationLink(destination: destinationView(using: movie)) {
                    MovieListItemView(movie: movie)
                        .padding(.trailing, 8)
                }
                .padding(.trailing, 16)
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Movies")
        }
        .navigationViewStyle(.stack)
        .onAppear {
            viewModel.loadPopularMovies()
        }
    }
    
    func destinationView(using movie: Movie) -> some View {
        MovieDetailsScreen(viewModel: MovieDetailsScreenViewModel(movie: movie))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MoviesScreen(viewModel: MockViewModel(), diContainer: DIContainer.shared)
                .preferredColorScheme(.light)
            MoviesScreen(viewModel: MockViewModel(), diContainer: DIContainer.shared)
                .preferredColorScheme(.dark)
        }
    }
}
