//
//  MovieDetailsModuleFactory.swift
//  MovieDetails
//
//  Created by ahmed gado on 12/08/2025.
//

import GeneralSwift
import GadoNetwork

@MainActor
public class MovieDetailsModuleFactory {
    public static func makeModule(with coordinator: MoviesCoordinatorProtocol) -> MovieDetailsView {
        // API Client
        let baseAPIClient = BaseAPIClient()
        let movieDetailsClient = MovieDetailsAPIClient(client: baseAPIClient)
        // repository
        let repository = MovieDetailsRepository(client: movieDetailsClient)
        // useCase
        let useCase = MovieDetailsUseCase(repository: repository)
        // ViewModel
        let viewModel = MovieDetailsViewModel(useCase: useCase,
                                              coordinator: coordinator)
        // View
        return MovieDetailsView(viewModel: viewModel)
    }
}
