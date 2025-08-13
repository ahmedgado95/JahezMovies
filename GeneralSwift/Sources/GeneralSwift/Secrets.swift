//
//  Secrets.swift
//  JahezMovies
//
//  Created by ahmed gado on 12/08/2025.
//

import Foundation

public
enum Secrets {
    public static var apiKey: String {
        guard let key = Bundle.main.infoDictionary?["API_KEY"] as? String  else {
            fatalError("Api Key not found")
        }
        return key
    }
}
