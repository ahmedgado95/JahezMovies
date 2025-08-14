//
//  MovieDetailsViewModel.swift
//  MovieDetails
//
//  Created by ahmed gado on 12/08/2025.
//

import Combine
import GeneralSwift

final class MovieDetailsViewModel: ObservableObject {
    // MARK: - Vars
    @Published var state = MovieDetailsViewState()
    var movieID: String {
        coordinator.getMovieID() ?? ""
    }
    var posterURL: String {
        "\(Constants.Network.imageBaseURL)\(state.movieDetails.posterPath)"
    }
    var titleWithDate: String {
        "\(state.movieDetails.originalTitle) (\(state.movieDetails.releaseDate.yearOnly()))"
    }
    var genreNames: String {
        state.movieDetails.genres.map { $0.name }.joined(separator: ", ")
    }
    var languages: String {
        state.movieDetails.spokenLanguages.compactMap { $0.name }.joined(separator: ", ")
    }
    private var cancellable: Set<AnyCancellable> = []
    
    // MARK: - Dependencies
    private var useCase: MovieDetailsUseCaseProtocol
    private var coordinator: MoviesCoordinatorProtocol
    
    init(useCase: MovieDetailsUseCaseProtocol, coordinator: MoviesCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}

// MARK: - MovieDetailsViewModel
extension MovieDetailsViewModel {
    func showMovieDetails() {
        state.isLoading = true
        useCase.fetchMovieDetails(id: movieID)
            .sink { [weak self] completion in
                guard let self else {
                    return
                }
                if case .failure = completion {
                    state.isLoading = false
                }
            } receiveValue: { [weak self] details in
                guard let self else { return }
                state.movieDetails = details
                state.isLoading = false
            }
            .store(in: &cancellable)
    }
    
    func back() {
        coordinator.goBack(animated: true)
    }
}
