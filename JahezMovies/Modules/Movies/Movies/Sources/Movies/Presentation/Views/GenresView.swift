//
//  GenresView.swift
//  Movies
//
//  Created by ahmed gado on 13/08/2025.
//
import SwiftUI
import GeneralSwift

struct GenresView: View {
    @ObservedObject var viewModel: MoviesViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach( viewModel.state.genres, id: \.id) { genre in
                    let isSelected = viewModel.state.selectedGenre == genre
                    let textColor = isSelected ? Color.black : Color.white
                    let backgroundColor = isSelected ? Color(hex: Constants.Color.yellowColor) : Color.black
                    Button(action: {
                        viewModel.state.selectedGenre = genre
                    }) {
                        Text(genre.name)
                            .foregroundColor(textColor)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .fill(backgroundColor)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color(hex: Constants.Color.yellowColor), lineWidth: 3)
                                    )
                            )
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(Color.clear)
    }
}
