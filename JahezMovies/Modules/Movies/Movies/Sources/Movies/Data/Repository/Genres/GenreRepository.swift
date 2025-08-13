//
//  GenreRepository.swift
//  Movies
//
//  Created by ahmed gado on 13/08/2025.
//


import Combine
import GadoNetwork

class GenreRepository {
    private var cancellable: Set<AnyCancellable> = []
    private var client: MoviesAPIClientProtocol
    
    init(client: MoviesAPIClientProtocol) {
        self.client = client
    }
    
    // MARK: - Privates
    private
    func convertGenres(_ response: GenreResponse?) -> [GenreRepositoryModel]? {
        response?.genres?.compactMap({ genre in
            GenreRepositoryModel(
                id: genre.id,
                name: genre.name
            )
        })
    }
    
}

// MARK: - GenreRepositoryProtocol
extension  GenreRepository: GenreRepositoryProtocol {
    func getGenre() -> AnyPublisher<[GenreRepositoryModel]?, RepositoryError> {
        return Future { [weak self] promise in
            guard let self else { return }
            client.getGenre()
                .sink(receiveCompletion: { result in
                    if case .failure(let error) = result {
                        promise(.failure(
                            RepositoryError(error: error)
                        ))
                    }
                }, receiveValue: { [weak self] response in
                    guard let self else { return }
                    promise(.success(
                        self.convertGenres(response)
                    ))
                })
                .store(in: &cancellable)
        }
        .eraseToAnyPublisher()
    }
}
