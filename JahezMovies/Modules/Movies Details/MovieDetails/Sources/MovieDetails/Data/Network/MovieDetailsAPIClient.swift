//
//  MovieDetailsAPIClient.swift
//  MovieDetails
//
//  Created by ahmed gado on 12/08/2025.
//

import Combine
import GadoNetwork

protocol MovieDetailsAPIClientProtocol {
  func getMovieDetails(id: String) -> AnyPublisher<MovieDetailsResponse, SessionDataTaskError>
}

class MovieDetailsAPIClient {
  private var client: BaseAPIClientProtocol
  init(client: BaseAPIClientProtocol) {
    self.client = client
  }
}

// MARK: - MovieDetailsAPIClientProtocol
extension MovieDetailsAPIClient: MovieDetailsAPIClientProtocol {
  func getMovieDetails(id: String) -> AnyPublisher<MovieDetailsResponse, SessionDataTaskError> {
    let request = MovieDetailsAPIRequest.getMovieDetails(id: id)
    return client.perform(request.asURLRequest())
  }
}
