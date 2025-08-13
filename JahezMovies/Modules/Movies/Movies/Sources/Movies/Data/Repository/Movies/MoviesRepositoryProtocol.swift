//
//  MoviesRepositoryProtocol.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//

import GadoNetwork
import Combine

// MARK: - MoviesRepositoryGettable
protocol MoviesRepositoryProtocol: MoviesRepositoryGettable { }

protocol MoviesRepositoryGettable {
    func getMovies(for currentPage: Int) -> AnyPublisher<MoviesRepositoryModel?, RepositoryError>
}
