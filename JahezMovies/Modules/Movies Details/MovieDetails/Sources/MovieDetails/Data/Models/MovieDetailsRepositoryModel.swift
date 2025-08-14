//
//  MovieDetailsRepositoryModel.swift
//  MovieDetails
//
//  Created by ahmed gado on 12/08/2025.
//

import Foundation

// MARK: - MovieDetailsRepositoryModel
struct MovieDetailsRepositoryModel {
  let id: Int?
  let originalLanguage, originalTitle, overview: String?
  let status: String?
  let posterPath: String?
  let releaseDate: String?
  let genres: [MovieDetailsGenreRepositoryModel]?
  let homepage: String?
  let budget: Int?
  let revenue, runtime: Int?
  let spokenLanguages: [SpokenLanguageRepositoryModel]?
}

// MARK: - MovieDetailsGenreRepositoryModel
struct MovieDetailsGenreRepositoryModel {
    let id: Int?
    let name: String?
}

// MARK: - SpokenLanguageRepositoryModel
struct SpokenLanguageRepositoryModel {
    let englishName, name: String?
}
