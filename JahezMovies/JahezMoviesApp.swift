//
//  JahezMoviesApp.swift
//  JahezMovies
//
//  Created by ahmed gado on 12/08/2025.
//

import SwiftUI

@main
struct JahezMoviesApp: App {
    var body: some Scene {
        WindowGroup {
            let navigationController = UINavigationController()
            let coordinator = MoviesCoordinator(navigationController: navigationController)
            MoviesCoordinatorView(coordinator: coordinator)
        }
    }
}
