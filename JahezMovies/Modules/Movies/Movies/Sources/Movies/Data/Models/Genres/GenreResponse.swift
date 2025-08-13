//
//  GenreResponse.swift
//  Movies
//
//  Created by ahmed gado on 13/08/2025.
//

// MARK: - GenreResponse
struct GenreResponse: Codable {
    let genres: [Genre]?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}
