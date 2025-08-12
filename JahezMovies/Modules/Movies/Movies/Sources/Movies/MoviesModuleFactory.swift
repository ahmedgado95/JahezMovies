//
//  MoviesModuleFactory.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//

import Foundation
import GeneralSwift


public
class MoviesModuleFactory {
    public
    static func makeModule(with coordinator: MoviesCoordinatorProtocol) -> MoviesView {
        // ViewModel
        let viewModel = MoviesViewModel()
        
        // View
        return MainActor.assumeIsolated {
            MoviesView(viewModel: viewModel)
        }
    }
}
