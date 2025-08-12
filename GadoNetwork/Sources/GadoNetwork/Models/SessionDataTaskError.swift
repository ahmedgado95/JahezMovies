//
//  SessionDataTaskError.swift
//  GadoNetwork
//
//  Created by ahmed gado on 11/08/2025.
//

import Foundation

public
enum SessionDataTaskError: Error {
  case failWithError(Error)
  case notValidURL
  case requestFailed
  case noData
  case notFound
  case notAuthorized
  case server
  case noInternetConnection
  case internalError(SessionDataTaskErrorResponse)
  case emptyErrorWithStatusCode(String)
}
