//
//  MoviesViewModelTests.swift
//  Movies
//
//  Created by ahmed gado on 15/08/2025.
//

import XCTest
@testable import Movies
import Combine
import GeneralSwift
import GadoNetwork

final class MoviesViewModelTests: XCTestCase {
    var viewModel: MoviesViewModel!
    var mockUseCase: MockMoviesUseCase!
    var mockCoordinator: MockMoviesCoordinator!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockMoviesUseCase()
        mockCoordinator = MockMoviesCoordinator()
        viewModel = MoviesViewModel(useCase: mockUseCase, coordinator: mockCoordinator)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        mockCoordinator = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_getMovies_failure_setsIsLoadingFalse() {
        
        let failingUseCase = FailingMoviesUseCase()
        viewModel = MoviesViewModel(useCase: failingUseCase, coordinator: mockCoordinator)
        
        let expectation = XCTestExpectation(description: "Movies fetch failed")
        
        viewModel.getMovies()
        
        viewModel.$state
            .dropFirst()
            .sink { state in
                if !state.isLoading {
                    XCTAssertTrue(state.movies.isEmpty)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }

    func test_getMovies_success_loadsMovies() {
        let expectedMovies = [
            MovieItem(posterPath: "1", title: "Movie 1", releaseDate: "2020", genres: [], id: 1, voteAverage: 0.0, voteCount: 2, overview: "overview 1"),
            MovieItem(posterPath: "2", title: "Movie 2", releaseDate: "2050", genres: [], id: 2, voteAverage: 0.0, voteCount: 2, overview: "overview 2"),
        ]
        
        mockUseCase.moviesToReturn = expectedMovies
        
        let expectation = XCTestExpectation(description: "Movies loaded")
        
        viewModel.$state
            .dropFirst()
            .sink { state in
                if !state.isLoading {
                    XCTAssertEqual(state.movies.count, 2)
                    XCTAssertEqual(state.movies.first?.title, "Movie 1")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.getMovies()
        wait(for: [expectation], timeout: 1)
    }
    
    func test_searchMovies_selectedMoviesByTitle() {
        viewModel.state.movies = [
            MovieItem(posterPath: "1", title: "Movie 1", releaseDate: "", genres: [], id: 0, voteAverage: 0, voteCount: 0, overview: ""),
            MovieItem(posterPath: "2", title: "Movie 2", releaseDate: "", genres: [], id: 0, voteAverage: 0, voteCount: 0, overview: "")
        ]
        
        viewModel.searchText = "Movie 1"
        viewModel.searchMovies()
        
        XCTAssertEqual(viewModel.state.selectedMovies.count, 1)
        XCTAssertEqual(viewModel.state.selectedMovies.first?.title, "Movie 1")
    }
    
}


