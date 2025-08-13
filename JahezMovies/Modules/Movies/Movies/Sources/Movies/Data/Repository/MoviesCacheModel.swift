//
//  MoviesCacheModel.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//

import Foundation
import SwiftData

@available(iOS 17, *)
@Model
class MoviesCacheModel {
    @Attribute(.unique) var id: Int
    var title: String?
    var posterPath: String?
    var releaseDate: String?
    var voteAverage: Double?
    var voteCount: Int?
    var overview: String?

    init(
        id: Int,
        title: String?,
        posterPath: String?,
        releaseDate: String?,
        voteAverage: Double?,
        voteCount: Int?,
        overview: String?
    ) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.overview = overview
    }
}
