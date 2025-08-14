//
//  MovieDetailsAPIRequest.swift
//  MovieDetails
//
//  Created by ahmed gado on 12/08/2025.
//

import GadoNetwork
import GeneralSwift

enum MovieDetailsAPIRequest: APIRequestConfiguration {
  case getMovieDetails(id: String)

  var method: HTTPMethod {
    switch self {
      case .getMovieDetails:
        return .GET
    }
  }

  var path: String {
    switch self {
      case .getMovieDetails(let id):
        return "\(Constants.Network.baseURL)movie/\(id)?\(Secrets.apiKey)"
    }
  }

  var parameters: Parameters? {
    nil
  }

  var headers: HTTPHeaders? {
    nil
  }

  var queryParams: [String : Any]? {
    nil
  }

  var files: [UploadMediaFile]? {
    nil
  }
}
