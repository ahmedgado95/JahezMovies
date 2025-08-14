//
//  MovieDetailsRepositoryProtocol.swift
//  MovieDetails
//
//  Created by ahmed gado on 12/08/2025.
//

import Combine
import GadoNetwork

protocol MovieDetailsRepositoryProtocol: MovieDetailsRepositoryGettable { }

protocol MovieDetailsRepositoryGettable {
  func getMovieDetails(id: String) -> AnyPublisher<MovieDetailsRepositoryModel?, RepositoryError>
}
