//
//  MoviesViewModel.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//

import Combine
import SwiftUI

final class MoviesViewModel: ObservableObject {
    @Published var movies: [String] = [
        "first", "second", "third", "fourth",
        "fifth", "sixth", "seventh", "eighth", "ninth", "tenth"
    ]
    
    @Published var genres: [String] = [
        "one", "two", "three", "four", "five",
        "six", "seven", "eight", "nine", "ten"
    ]
    
    let columnsGrids = Array(repeating: GridItem(.flexible()), count: 2)
    @Published var selectedCategory: String?
    
    init() {
        self.selectedCategory = genres.first
    }
}
