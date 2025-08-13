//
//  MoviesResponseModel.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//


import Foundation
import SwiftData

// MARK: - MovieResponseModel
struct MovieResponseModel: Codable {
    let page: Int?
    let movies: [MovieItemResponse]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - MovieItemResponse
struct MovieItemResponse: Codable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, title: String?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
