//
//  MoviesUseCase.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//


import Foundation
import Combine
import GeneralSwift

final class MoviesUseCase {
    // MARK: - Private Vars
    private var cancellable: Set<AnyCancellable> = []
    
    // MARK: - Dependencies
    private var moviesRepository: MoviesRepositoryProtocol
    private var genreRepository: GenreRepositoryProtocol
    
    init(moviesRepository: MoviesRepositoryProtocol, genreRepository: GenreRepositoryProtocol) {
        self.moviesRepository = moviesRepository
        self.genreRepository = genreRepository
    }
    
    
    // MARK: - Privates
    private func convertMovies(_ repositoryItem: [MovieRepositoryModel]?) -> [MovieItem] {
        guard let movies = repositoryItem else { return [] }
        return movies.compactMap({ movie in
            MovieItem(
                posterPath: movie.posterPath ?? "",
                title: movie.title ?? "",
                releaseDate: movie.releaseDate ?? "",
                genres: movie.genres ?? [],
                id: movie.id ?? 0,
                voteAverage: movie.voteAverage ?? 0.0,
                voteCount: movie.voteCount ?? 0,
                overview: movie.overview ?? ""
            )
        })
    }
    
    private
    func convert(_ repositoryItem: MoviesRepositoryModel?) -> MoviesItems {
        MoviesItems(
            page: repositoryItem?.page ?? 0,
            movies: convertMovies(repositoryItem?.movies),
            totalPages: repositoryItem?.totalPages ?? 0
        )
    }
    
    private
    func convertGenres(_ genres: [GenreRepositoryModel]?) -> [MovieGenre] {
      genres?.compactMap({ genre in
        MovieGenre(
          id: genre.id ?? 0,
          name:genre.name ?? ""
        )
      }) ?? []
    }

    
}

// MARK: - MoviesUseCaseProtocol
extension MoviesUseCase: MoviesUseCaseProtocol {
    func fetchMovies(for currentPage: Int) -> AnyPublisher<MoviesItems, GeneralError> {
        return Future { [weak self] promise in
            guard let self else { return }
            moviesRepository.getMovies(for: currentPage)
                .sink(receiveCompletion: { result in
                    if case .failure(let error) = result {
                        promise(.failure(
                            GeneralError(error: error)
                        ))
                    }
                }, receiveValue: { [weak self] response in
                    guard let self else { return }
                    promise(.success(
                        self.convert(response)
                    ))
                })
                .store(in: &cancellable)
        }
        .eraseToAnyPublisher()
    }
    
    func fetchGenres() -> AnyPublisher<[MovieGenre], GeneralError> {
      return Future { [weak self] promise in
        guard let self else { return }
          genreRepository.getGenre()
          .sink(receiveCompletion: { result in
            if case .failure(let error) = result {
              promise(.failure(
                GeneralError(error: error)
              ))
            }
          }, receiveValue: { [weak self] response in
            guard
              let self,
              let response
            else { return }
            promise(.success(convertGenres(response)))
          })
          .store(in: &cancellable)
        }
      .eraseToAnyPublisher()
    }

}
