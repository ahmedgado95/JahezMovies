//
//  MovieDetailsUseCase.swift
//  MovieDetails
//
//  Created by ahmed gado on 12/08/2025.
//

import Combine
import GeneralSwift


final class MovieDetailsUseCase {
  // MARK: - Vars
  private var cancellable: Set<AnyCancellable> = []

  // MARK: - Dependencies
  private var repository: MovieDetailsRepositoryProtocol

  init(repository: MovieDetailsRepositoryProtocol) {
    self.repository = repository
  }

  // MARK: - Privates
  private func convertGenre(_ response: [MovieDetailsGenreRepositoryModel]?) -> [MovieDetailsGenre]? {
    guard let genres = response else {return nil}
    return genres.map { genre in
      MovieDetailsGenre(
        id: genre.id ?? 0,
        name: genre.name ?? ""
      )
    }
  }

  private func convertSpokenLanguage(_ response: [SpokenLanguageRepositoryModel]?) -> [SpokenLanguage]? {
    guard let languages = response else {return nil}
    return languages.map { language in
      SpokenLanguage(
        englishName: language.englishName ?? "",
        name: language.name ?? ""
      )
    }
  }

  private
  func convert(_ response: MovieDetailsRepositoryModel?) -> MovieDetailsItem {
    return MovieDetailsItem(
      id: response?.id ?? 0,
      originalLanguage: response?.originalLanguage ?? "",
      originalTitle: response?.originalTitle ?? "",
      overview: response?.overview ?? "",
      status: response?.status ?? "",
      posterPath: response?.posterPath ?? "",
      releaseDate: response?.releaseDate ?? "",
      genres: convertGenre(response?.genres) ?? [],
      homepage: response?.homepage ?? "",
      budget: response?.budget ?? 0,
      revenue: response?.revenue ?? 0,
      runtime: response?.runtime ?? 0,
      spokenLanguages: convertSpokenLanguage(response?.spokenLanguages) ?? []
    )
  }
}

// MARK: - MovieDetailsUseCaseProtocol
extension MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    func fetchMovieDetails(id: String) -> AnyPublisher<MovieDetailsItem, GeneralError> {
    return Future { [weak self] promise in
      guard let self else { return }
        repository.getMovieDetails(id: id)
        .sink(receiveCompletion: { result in
          if case .failure(let error) = result {
            promise(.failure(GeneralError(error: error)))
          }
        }, receiveValue: { [weak self] response in
          guard let self else { return }
          promise(.success(convert(response)))
        })
        .store(in: &cancellable)
    }
    .eraseToAnyPublisher()
  }
}
