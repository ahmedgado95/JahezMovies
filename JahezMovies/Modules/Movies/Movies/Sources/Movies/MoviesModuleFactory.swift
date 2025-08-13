//
//  MoviesModuleFactory.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//

import Foundation
import GeneralSwift
import GadoNetwork
import SwiftData

@MainActor
public
class MoviesModuleFactory {
    @available(iOS 17, *)
    public
    static func makeModule(with coordinator: MoviesCoordinatorProtocol) -> MoviesView {
        // API Client
        let baseAPIClient = BaseAPIClient()
        let moviesClient = MoviesAPIClient(client: baseAPIClient)
        
        // Repository
        let config = ModelConfiguration(for: MoviesCacheModel.self)
        let container = try! ModelContainer(for: MoviesCacheModel.self,
                                            configurations: config)
        let cacheManager = ModelContext(container)
        let moviesRepository = MoviesRepository(client: moviesClient,
                                                modelContext: cacheManager)
        
        let genreRepository = GenreRepository(client: moviesClient)
        
        // Use Case
        let useCase = MoviesUseCase(moviesRepository: moviesRepository,
                                    genreRepository: genreRepository)
        
        // ViewModel
        let viewModel = MoviesViewModel(useCase: useCase,
                                        coordinator: coordinator)
        // View
        return MainActor.assumeIsolated {
            MoviesView(viewModel: viewModel)
        }
    }
}
