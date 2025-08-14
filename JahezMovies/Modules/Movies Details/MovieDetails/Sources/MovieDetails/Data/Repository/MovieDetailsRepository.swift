//
//  MovieDetailsRepository.swift
//  MovieDetails
//
//  Created by ahmed gado on 12/08/2025.
//

import Combine
import GadoNetwork
import GeneralSwift

final class MovieDetailsRepository {
    // MARK: - Vars
    private var cancellable: Set<AnyCancellable> = []
    private var client: MovieDetailsAPIClientProtocol
    
    init(client: MovieDetailsAPIClientProtocol) {
        self.client = client
    }
    
    // MARK: - Privates
    private func convertGenre(_ response: [MovieDetailsGenreResponse]?) -> [MovieDetailsGenreRepositoryModel]? {
        guard let genres = response else {return nil}
        return genres.map { genre in
            MovieDetailsGenreRepositoryModel(
                id: genre.id,
                name: genre.name
            )
        }
    }
    
    private func convertSpokenLanguage(_ response: [SpokenLanguageResponse]?) -> [SpokenLanguageRepositoryModel]? {
        guard let languages = response else {return nil}
        return languages.map { language in
            SpokenLanguageRepositoryModel(
                englishName: language.englishName,
                name: language.name
            )
        }
    }
    
    private func convert(_ response: MovieDetailsResponse?) -> MovieDetailsRepositoryModel? {
        return MovieDetailsRepositoryModel(
            id: response?.id,
            originalLanguage: response?.originalLanguage,
            originalTitle: response?.originalTitle,
            overview: response?.overview,
            status: response?.status,
            posterPath: "\(Constants.Network.imageBaseURL)\(response?.posterPath ?? "")",
            releaseDate: response?.releaseDate,
            genres: convertGenre(response?.genres),
            homepage: response?.homepage,
            budget: response?.budget,
            revenue: response?.revenue,
            runtime: response?.runtime,
            spokenLanguages: convertSpokenLanguage(response?.spokenLanguages)
        )
    }
}

// MARK: - MovieDetailsRepositoryProtocol
extension MovieDetailsRepository: MovieDetailsRepositoryProtocol {
    func getMovieDetails(id: String) -> AnyPublisher<MovieDetailsRepositoryModel?, RepositoryError> {
        return Future { [weak self] promise in
            guard let self else { return }
            client.getMovieDetails(id: id)
                .sink(receiveCompletion: { result in
                    if case .failure(let error) = result {
                        promise(.failure(
                            RepositoryError(error: error)
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
}
