//
//  GenreRepositoryProtocol.swift
//  Movies
//
//  Created by ahmed gado on 13/08/2025.
//

import Combine
import GadoNetwork

protocol GenreRepositoryProtocol: GenreRepositoryGettable { }

protocol GenreRepositoryGettable {
  func getGenre() -> AnyPublisher<[GenreRepositoryModel]?, RepositoryError>
}

