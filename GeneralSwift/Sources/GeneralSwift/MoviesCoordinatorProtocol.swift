//
//  MoviesCoordinatorProtocol.swift
//  GeneralSwift
//
//  Created by ahmed gado on 12/08/2025.
//

import UIKit

public
protocol MoviesCoordinatorProtocol {
  func start()
  func setRootViewController<T: UIViewController>(_ rootViewController: T) -> UINavigationController
  func push<T: UIViewController>(_ viewController: T, animated: Bool)
  func goBack(animated: Bool)
  func present<T: UIViewController>(_ viewController: T, animated: Bool)
}
