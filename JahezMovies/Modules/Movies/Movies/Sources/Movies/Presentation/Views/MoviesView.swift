//
//  MoviesView.swift
//  Movies
//
//  Created by ahmed gado on 12/08/2025.
//

import SwiftUI
import GeneralSwift

public struct MoviesView: View {
    @StateObject private var viewModel: MoviesViewModel
    
    init(viewModel: MoviesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(hex: "#F5C519")
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(hex: "#F5C519")
        ]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    public var body: some View {
        SearchBar(viewModel: viewModel)
        NavigationView {
            VStack {
                GenresView(viewModel: viewModel)
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: viewModel.columnsGrids,
                              spacing: 4) {
                        ForEach(viewModel.state.movies, id: \.id) { movie in
                            MovieCardView(title: movie.title,
                                          date: movie.releaseDate,
                                          url: movie.posterPath)
                        }
                    }
                }
            }
            .navigationTitle("Watch New Movies")
            .redacted(reason: viewModel.state.isLoading ? .placeholder : [])
        }
        .onAppear {
            viewModel.getMovies()
            viewModel.showGenres()
        }
    }
}

private struct MovieCardView: View {
    var title: String
    var date: String
    var url: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string:"\(Constants.Network.imageBaseURL)\(url ?? "")")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        .clipped()
                } else if phase.error != nil || url == nil || url?.isEmpty == true {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 180)
                        .foregroundColor(.gray)
                        .background(Color.secondary.opacity(0.3))
                        .clipped()
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: 180)
                        .background(Color.secondary.opacity(0.3))
                }
            }
          
            
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(4)
            
            Text(date)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 4)
                .padding(.bottom, 12)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color(red: 0.102, green: 0.102, blue: 0.102))
        .padding(4)
    }
}
