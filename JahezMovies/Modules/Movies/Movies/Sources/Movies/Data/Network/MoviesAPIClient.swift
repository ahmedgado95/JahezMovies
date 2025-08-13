//
//  MoviesAPIClient.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//

import Combine
import GadoNetwork

protocol MoviesAPIClientProtocol {
    func getMovies(for currentPage: Int) -> AnyPublisher<MovieResponseModel, SessionDataTaskError>
    func getGenre() -> AnyPublisher<GenreResponse, SessionDataTaskError>
}

// MARK: - MoviesAPIClient
class MoviesAPIClient {
  private var client: BaseAPIClientProtocol
  init(client: BaseAPIClientProtocol) {
    self.client = client
  }
}

// MARK: - MoviesAPIClientProtocol
extension MoviesAPIClient: MoviesAPIClientProtocol {
    func getMovies(for currentPage: Int) -> AnyPublisher<MovieResponseModel, SessionDataTaskError> {
        let request = MoviesAPIRequest.getMovies(currentPage: currentPage)
        return client.perform(request.asURLRequest())
    }
    
    func getGenre() -> AnyPublisher<GenreResponse, GadoNetwork.SessionDataTaskError> {
        let request = MoviesAPIRequest.getGenre
        return client.perform(request.asURLRequest())
    }
    
}
