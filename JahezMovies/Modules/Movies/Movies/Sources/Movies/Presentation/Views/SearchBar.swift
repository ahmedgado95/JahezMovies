//
//  SearchBar.swift
//  Movies
//
//  Created by ahmed gado on 13/08/2025.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var viewModel: MoviesViewModel
    
    var body: some View {
        HStack {
            TextField("Search TMDB",
                      text: $viewModel.searchText)
            .padding(7)
            .padding(.horizontal, 30)
            .foregroundColor(Color(.systemGray6))
            .background(Color(red: 0.102, green: 0.102, blue: 0.102))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                }
            )
            .padding(.horizontal, 12)
        }
    }
}
