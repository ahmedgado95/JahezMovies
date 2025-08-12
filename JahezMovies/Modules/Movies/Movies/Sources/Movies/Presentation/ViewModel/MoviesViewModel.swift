//
//  MoviesViewModel.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//

import Combine
import SwiftUI

final class MoviesViewModel: ObservableObject {
    // MARK: - Vars
    @Published var movies: [String] = ["first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth"]
    let columnsGrids = Array(repeating: GridItem(.flexible()), count: 2)
}
