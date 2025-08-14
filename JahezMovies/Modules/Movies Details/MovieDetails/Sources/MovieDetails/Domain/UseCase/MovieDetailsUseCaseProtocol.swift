//
//  MovieDetailsUseCaseProtocol.swift
//  MovieDetails
//
//  Created by ahmed gado on 12/08/2025.
//

import Combine
import GeneralSwift

protocol MovieDetailsUseCaseProtocol {
    func fetchMovieDetails(id: String) -> AnyPublisher<MovieDetailsItem, GeneralError>
}

// MARK: - MovieDetailsItem
struct MovieDetailsItem {
  let id: Int
  let originalLanguage, originalTitle, overview: String
  let status: String
  var posterPath: String
  let releaseDate: String
  let genres: [MovieDetailsGenre]
  let homepage: String
  let budget: Int
  let revenue, runtime: Int
  let spokenLanguages: [SpokenLanguage]

  init(
    id: Int = 0,
    originalLanguage: String = "",
    originalTitle: String = "",
    overview: String = "",
    status: String = "",
    posterPath: String = "",
    releaseDate: String = "",
    genres: [MovieDetailsGenre] = [],
    homepage: String = "",
    budget: Int = 0,
    revenue: Int = 0,
    runtime: Int = 0,
    spokenLanguages: [SpokenLanguage] = []
  ) {
    self.id = id
    self.originalLanguage = originalLanguage
    self.originalTitle = originalTitle
    self.overview = overview
    self.status = status
    self.posterPath = posterPath
    self.releaseDate = releaseDate
    self.genres = genres
    self.homepage = homepage
    self.budget = budget
    self.revenue = revenue
    self.runtime = runtime
    self.spokenLanguages = spokenLanguages
  }
}

// MARK: - MovieDetailsGenre
struct MovieDetailsGenre {
    let id: Int
    let name: String
}

// MARK: - SpokenLanguage
struct SpokenLanguage {
    let englishName, name: String?
}
