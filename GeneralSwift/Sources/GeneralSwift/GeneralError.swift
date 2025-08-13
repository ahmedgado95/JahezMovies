//
//  GeneralError.swift
//  GeneralSwift
//
//  Created by ahmed gado on 13/08/2025.
//

import GadoNetwork

public
enum GeneralError: Error {
  case noInternetConnection
  case notFound
  case notAuthorized
  case server
  case noData
  case unowned

  public
  init(error: RepositoryError) {
    switch error {
      case .noInternetConnection:
        self = .noInternetConnection
      case .server:
        self = .server
      case .notFound:
        self = .notFound
      case .notAuthorized:
        self = .notAuthorized
      default:
        self = .unowned
    }
  }
}
