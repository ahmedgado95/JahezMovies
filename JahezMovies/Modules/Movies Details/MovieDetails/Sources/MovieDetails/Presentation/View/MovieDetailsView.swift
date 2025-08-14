//
//  MovieDetailsView.swift
//  MovieDetails
//
//  Created by ahmed gado on 12/08/2025.
//

import SwiftUI

struct MovieDetailsView: View {
    @StateObject private var viewModel: MovieDetailsViewModel
    
    init(viewModel: MovieDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("This is Movie Details View for Movie ID:\(viewModel.movieID)")
            }
        }
    }
}
