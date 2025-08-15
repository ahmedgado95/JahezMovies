//
//  MockMoviesCoordinator.swift
//  Movies
//
//  Created by ahmed gado on 15/08/2025.
//

import UIKit
import GeneralSwift

// MARK: - MoviesCoordinatorProtocol
final class MockMoviesCoordinator: MoviesCoordinatorProtocol {
    var selectedMovieID: Int?
    
    func start() { }
    func setRootViewController<T>(_ rootViewController: T) -> UINavigationController where T: UIViewController {
        return MainActor.assumeIsolated {
            UINavigationController()
        }
    }
    func push<T>(_ viewController: T, animated: Bool) where T: UIViewController { }
    func goBack(animated: Bool) { }
    func present<T>(_ viewController: T, animated: Bool) where T: UIViewController { }
    func showMovieDetail(id: String) { }
    func showMovieDetails(movieID: Int) {
        selectedMovieID = movieID
    }
    func getMovieID() -> String? {
        nil
    }
}
