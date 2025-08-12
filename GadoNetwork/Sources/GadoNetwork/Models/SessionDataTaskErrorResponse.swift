//
//  SessionDataTaskErrorResponse.swift
//  GadoNetwork
//
//  Created by ahmed gado on 11/08/2025.
//

import Foundation

public
struct SessionDataTaskErrorResponse: Codable, Sendable{
  let error: SessionDataTaskErrorModel?
}

public
struct SessionDataTaskErrorModel: Codable, Sendable {
  let code: Int?
  let status: Int?
  let message: String?
}
