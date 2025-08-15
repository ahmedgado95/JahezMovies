//
//  MockMoviesUseCase.swift
//  Movies
//
//  Created by ahmed gado on 15/08/2025.
//

import Combine
import GeneralSwift
@testable import Movies
import Combine

// MARK: - MoviesUseCaseProtocol
final class MockMoviesUseCase: MoviesUseCaseProtocol {
    var moviesToReturn: [MovieItem] = []
    
    func fetchMovies(for currentPage: Int) -> AnyPublisher<Movies.MoviesItems, GeneralSwift.GeneralError> {
        let moviesItems = MoviesItems(page: 1, movies: moviesToReturn, totalPages: 1)
        return Just(moviesItems)
            .setFailureType(to: GeneralSwift.GeneralError.self)
            .eraseToAnyPublisher()
    }
    
    func fetchGenres() -> AnyPublisher<[Movies.MovieGenre], GeneralSwift.GeneralError> {
        let movieGenre = [
            MovieGenre(id: 0, name: "genr 1"),
            MovieGenre(id: 1, name: "genr 2")
        ]
        return Just(movieGenre)
            .setFailureType(to: GeneralSwift.GeneralError.self)
            .eraseToAnyPublisher()
    }
}

// MARK: - MoviesUseCaseProtocol
class FailingMoviesUseCase: MoviesUseCaseProtocol {
    func fetchMovies(for currentPage: Int) -> AnyPublisher<MoviesItems, GeneralSwift.GeneralError> {
        return Fail(error: .noData)
            .eraseToAnyPublisher()
    }
    func fetchGenres() -> AnyPublisher<[MovieGenre], GeneralSwift.GeneralError> {
        return Just([])
            .setFailureType(to: GeneralSwift.GeneralError.self)
            .eraseToAnyPublisher()
    }
}

