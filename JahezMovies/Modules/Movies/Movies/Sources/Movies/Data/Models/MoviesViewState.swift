//
//  MoviesViewState.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//

import Foundation

// MARK: - MovieViewState
struct MovieViewState {
    var movies: [MovieItem] = []
    var isLoading: Bool = false
    var genres: [MovieGenre] = []
    var selectedGenre: MovieGenre? = nil
    var hasMoreData = true
    var selectedMovies: [MovieItem] = []
    var noMoviesFound: Bool = false
}
