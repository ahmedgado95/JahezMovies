//
//  MovieDetailsModuleFactory.swift
//  MovieDetails
//
//  Created by ahmed gado on 12/08/2025.
//

import GeneralSwift

@MainActor
class MovieDetailsModuleFactory {
    static func makeModule(with coordinator: MoviesCoordinatorProtocol) -> MovieDetailsView {
        // ViewModel
        let viewModel = MovieDetailsViewModel(coordinator: coordinator)
        // View
        return MovieDetailsView(viewModel: viewModel)
    }
}
