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
    @Published var searchText: String = "" {
           didSet { searchMovies() }
       }
       
    private var currentPage = 0
    private var cancellable: Set<AnyCancellable> = []
    
    let columnsGrids = Array(repeating: GridItem(.flexible()), count: 2)
    
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
        useCase.fetchMovies(for: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(_) = completion {
                    state.isLoading = false
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                
                state.movies += response.movies
                state.noMoviesFound = state.movies.isEmpty
                if state.selectedGenre != nil {
                    selectMovies()
                } else {
                    state.selectedMovies = state.movies
                }
                state.hasMoreData = currentPage < response.totalPages
                currentPage += 1
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
    
    func loadMovies() {
        currentPage = 1
        state.hasMoreData = true
        state.movies.removeAll()
        getMovies()
    }
    
    func loadNextPage(id: Int) {
        guard !state.isLoading, state.hasMoreData else { return }
        if id == state.movies.last?.id {
            getMovies()
        }
    }
    
    func selectMovies() {
        guard let selectedGenre = state.selectedGenre else {
            state.selectedMovies = state.movies
            state.noMoviesFound = state.selectedMovies.isEmpty
            return
        }
        
        let filtered = state.movies.filter { $0.genres.contains(selectedGenre.id) }
        state.selectedMovies = filtered
        state.noMoviesFound = filtered.isEmpty
    }
    
    func searchMovies() {
        let query = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        var filtered = state.movies
        
        if let selectedGenre = state.selectedGenre {
            filtered = filtered.filter { $0.genres.contains(selectedGenre.id) }
        }
        
        if !query.isEmpty {
            filtered = filtered.filter { $0.title.lowercased().contains(query) }
        }
        
        state.selectedMovies = filtered
        state.noMoviesFound = filtered.isEmpty
    }
    
    func showMovieDetail(id: Int) {
        coordinator.showMovieDetail(id: "\(id)")
    }

}
