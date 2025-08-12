//
//  Dictionary+Extensions.swift
//  GadoNetwork
//
//  Created by ahmed gado on 11/08/2025.
//

import Foundation

/// To be able to add two dictionaries to each other

extension Dictionary {
  static func + (lhs: Dictionary, rhs: Dictionary?) -> Dictionary {
    if rhs == nil {
      return lhs
    } else {
      var dic = lhs
      rhs!.forEach { dic[$0] = $1 }
      return dic
    }
  }
}
