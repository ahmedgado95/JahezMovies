//
//  MoviesUseCaseProtocol.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//

import Foundation
import Combine
import GadoNetwork
import GeneralSwift

protocol MoviesUseCaseProtocol {
    func fetchMovies(for currentPage: Int) -> AnyPublisher<MoviesItems, GeneralError>
    func fetchGenres() -> AnyPublisher<[MovieGenre], GeneralError>
}

struct MoviesItems {
  let page: Int
  let movies: [MovieItem]
  let totalPages: Int

  init(
    page: Int = 0,
    movies: [MovieItem] = [],
    totalPages: Int = 0
  ) {
    self.page = page
    self.movies = movies
    self.totalPages = totalPages
  }
}

struct MovieItem {
  var posterPath: String
  var title: String
  var releaseDate: String
  let id: Int
  let voteAverage: Double
  let voteCount: Int
  let overview: String
}


struct MovieGenre: Identifiable, Equatable {
  let id: Int
  let name: String
}
