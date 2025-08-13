//
//  MoviesRepositoryModel.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//

import Foundation

// MARK: - MoviesRepositoryModel
struct MoviesRepositoryModel {
    let page: Int?
    let movies: [MovieRepositoryModel]?
    let totalPages: Int?
}

// MARK: - MovieRepositoryModel
struct MovieRepositoryModel {
    let posterPath: String?
    let title: String?
    let releaseDate: String?
    let id: Int?
    let voteAverage: Double?
    let voteCount: Int?
    let overview: String?
}

extension MoviesRepositoryModel {
    init(from response: MovieResponseModel) {
        self.page = response.page
        self.totalPages = response.totalPages
        self.movies = response.movies?.map { item in
            MovieRepositoryModel(
                posterPath: item.posterPath,
                title: item.title,
                releaseDate: item.releaseDate,
                id: item.id,
                voteAverage: item.voteAverage,
                voteCount: item.voteCount,
                overview: item.overview
            )
        }
    }
}
