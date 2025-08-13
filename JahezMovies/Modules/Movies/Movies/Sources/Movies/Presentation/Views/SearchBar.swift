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
            .foregroundColor(Color(red: 0.443, green: 0.443, blue: 0.443))
            .background(Color(red: 0.102, green: 0.102, blue: 0.102))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                        .padding(.leading, 8)
                    
                    Spacer()
                    
                    if !viewModel.searchText.isEmpty {
                        Button(action: {
                            viewModel.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.white)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
            .padding(.horizontal, 12)
        }
        .onChange(of: viewModel.state.selectedGenre) { _ in
            viewModel.searchMovies()
        }
    }
}
