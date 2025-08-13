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
    private var genresData: String
    var releaseDate: String?
    var voteAverage: Double?
    var voteCount: Int?
    var overview: String?

    var genres: [Int] {
        get {
            (try? JSONDecoder().decode([Int].self, from: Data(genresData.utf8))) ?? []
        }
        set {
            genresData = (try? String(data: JSONEncoder().encode(newValue), encoding: .utf8)) ?? "[]"
        }
    }

    init(
        id: Int,
        title: String?,
        posterPath: String?,
        genres: [Int]?,
        releaseDate: String?,
        voteAverage: Double?,
        voteCount: Int?,
        overview: String?
    ) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.genresData = (try? String(data: JSONEncoder().encode(genres ?? []), encoding: .utf8)) ?? "[]"
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.overview = overview
    }
}
