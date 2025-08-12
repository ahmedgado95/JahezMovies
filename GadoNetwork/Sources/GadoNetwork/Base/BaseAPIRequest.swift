//
//  BaseAPIRequest.swift
//  GadoNetwork
//
//  Created by ahmed gado on 11/08/2025.
//

import Foundation

public
enum BaseAPIRequest: APIRequestConfiguration {
  // MARK: - HTTPMethod
  public
  var method: HTTPMethod {
    switch self {
      default:
        return .GET
    }
  }

  // MARK: - Path
  public
  var path: String {
    return ""
  }

  // MARK: - Parameters
  public
  var parameters: Parameters? {
    return [:]
  }

  // MARK: - Headers
  public
  var headers: HTTPHeaders? {
    return nil
  }

  public
  var queryParams: [String : Any]? {
    return nil
  }

  public
  var files: [UploadMediaFile]? {
    return nil
  }
}
