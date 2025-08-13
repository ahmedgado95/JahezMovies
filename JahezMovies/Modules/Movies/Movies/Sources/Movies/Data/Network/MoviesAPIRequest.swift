//
//  MoviesAPIRequest.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//

import GadoNetwork
import GeneralSwift

enum MoviesAPIRequest: APIRequestConfiguration {
    case getMovies(currentPage: Int)
    
    var method: HTTPMethod {
        switch self {
        case .getMovies:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .getMovies(let currentPage):
            return "\(Constants.Network.baseURL)\(Constants.Network.movieURL)\(currentPage)\(Secrets.apiKey)"
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
