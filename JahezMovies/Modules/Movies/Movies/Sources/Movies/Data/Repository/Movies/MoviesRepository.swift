//
//  MoviesRepository.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//

import SwiftData
import Combine
import GadoNetwork

// MARK: - MoviesRepository
@available(iOS 17, *)
class MoviesRepository {
    private var cancellable: Set<AnyCancellable> = []
    private var client: MoviesAPIClientProtocol
    private var modelContext: ModelContext
    
    init(client: MoviesAPIClientProtocol, modelContext: ModelContext) {
        self.client = client
        self.modelContext = modelContext
    }
}

// MARK: - MoviesRepositoryProtocol
@available(iOS 17, *)
extension MoviesRepository: MoviesRepositoryProtocol {
    static func save(movies: [MovieItemResponse], context: ModelContext) throws {
        let existingMovies = try context.fetch(FetchDescriptor<MoviesCacheModel>())
        
        for item in movies {
            if let movie = existingMovies.first(where: { $0.id == item.id }) {
                movie.title = item.title
                movie.posterPath = item.posterPath
                movie.genres = item.genres
                movie.releaseDate = item.releaseDate
                movie.voteAverage = item.voteAverage
                movie.voteCount = item.voteCount
                movie.overview = item.overview
            } else {
                let movie = MoviesCacheModel(
                    id: item.id ?? 0,
                    title: item.title,
                    posterPath: item.posterPath,
                    genres: item.genres,
                    releaseDate: item.releaseDate,
                    voteAverage: item.voteAverage,
                    voteCount: item.voteCount,
                    overview: item.overview
                )
                context.insert(movie)
            }
        }
        
        let newIDs = Set(movies.map { $0.id })
        for movie in existingMovies where !newIDs.contains(movie.id) {
            context.delete(movie)
        }
        
        try context.save()
    }
    
    func getMovies(for currentPage: Int) -> AnyPublisher<MoviesRepositoryModel?, RepositoryError> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            
            self.client.getMovies(for: currentPage)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure(_):
                        do {
                            let localMovies = try self.fetchLocalMovies()
                            promise(.success(localMovies))
                        } catch {
                            promise(.failure(RepositoryError(error: .noInternetConnection)))
                        }
                        
                    case .finished:
                        break
                    }
                }, receiveValue: { response in
                    do {
                        try Self.save(movies: response.movies ?? [], context: self.modelContext)
                        let repoModel = MoviesRepositoryModel(from: response)
                        promise(.success(repoModel))
                    } catch {
                        promise(.failure(RepositoryError(error: .requestFailed)))
                    }
                })
                .store(in: &self.cancellable)
        }
        .eraseToAnyPublisher()
    }
}

@available(iOS 17, *)
extension MoviesRepository {
    private func fetchLocalMovies() throws -> MoviesRepositoryModel? {
        let cachedMovies = try modelContext.fetch(FetchDescriptor<MoviesCacheModel>())
        let movies = cachedMovies.map { cache -> MovieRepositoryModel in
            MovieRepositoryModel(
                posterPath: cache.posterPath,
                title: cache.title,
                releaseDate: cache.releaseDate,
                id: cache.id,
                voteAverage: cache.voteAverage,
                voteCount: cache.voteCount,
                overview: cache.overview
            )
        }
        return MoviesRepositoryModel(page: nil, movies: movies, totalPages: nil)
    }
}
