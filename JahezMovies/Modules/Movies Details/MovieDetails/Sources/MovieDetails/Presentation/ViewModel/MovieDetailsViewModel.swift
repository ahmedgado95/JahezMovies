//
//  MovieDetailsViewModel.swift
//  MovieDetails
//
//  Created by ahmed gado on 12/08/2025.
//

import Combine
import GeneralSwift

final class MovieDetailsViewModel: ObservableObject {
    var movieID: String {
        coordinator.getMovieID() ?? ""
    }
    // MARK: - Dependencies
    private var coordinator: MoviesCoordinatorProtocol
    
    init(coordinator: MoviesCoordinatorProtocol) {
      self.coordinator = coordinator
    }
}
