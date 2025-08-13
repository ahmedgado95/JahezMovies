//
//  MoviesViewModel.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//

import Combine
import SwiftUI
import GeneralSwift

final class MoviesViewModel: ObservableObject {
    // MARK: - Vars
    @Published var state = MovieViewState()
    private var currentPage = 0
    private var cancellable: Set<AnyCancellable> = []
    
    let columnsGrids = Array(repeating: GridItem(.flexible()), count: 2)
    var searchText: String = ""

    // MARK: - Dependencies
    private var useCase: MoviesUseCaseProtocol
    private var coordinator: MoviesCoordinatorProtocol

    init(useCase: MoviesUseCaseProtocol, coordinator: MoviesCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}


// MARK: - Fetching Data
extension MoviesViewModel {
    func getMovies() {
        state.isLoading = true
        currentPage += 1
        useCase.fetchMovies(for: currentPage)
            .sink { [weak self] completion in
                guard let self else {
                    return
                }
                if case .failure = completion {
                    state.isLoading = false
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                state.movies += response.movies
                state.isLoading = false
            }
            .store(in: &cancellable)
    }
    
    func showGenres() {
      state.isLoading = true
      useCase.fetchGenres()
        .sink { [weak self] _ in
          guard let self else {
            return
          }
          state.isLoading = false
        } receiveValue: { [weak self] response in
          guard let self else { return }
          state.genres = response
          state.isLoading = false
        }
        .store(in: &cancellable)
    }
}
