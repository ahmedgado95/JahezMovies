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
        searchBarView
        NavigationView {
            VStack(spacing: 0) {
                moviesView
            }
            .navigationTitle("Watch New Movies")
        }
    }
    
    // MARK: - Subviews
    
    private var searchBarView: some View {
        SearchBar(viewModel: viewModel)
    }
    
    private var moviesView: some View {
        VStack {
            GenresView(viewModel: viewModel)
            if viewModel.state.noMoviesFound {
                Spacer()
                Text("No Movies Found !!")
                    .foregroundColor(.gray)
                    .font(.headline)
                Spacer()
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: viewModel.columnsGrids, spacing: 4) {
                        ForEach(viewModel.state.selectedMovies, id: \.id) { movie in
                            MovieCardView(
                                title: movie.title,
                                date: movie.releaseDate,
                                url: movie.posterPath
                            )
                            .onAppear {
                                viewModel.loadNextPage(id: movie.id)
                            }
                        }
                        
                        if viewModel.state.isLoading {
                            ProgressView()
                                .padding()
                        }
                    }
                }
                .redacted(reason: viewModel.state.isLoading ? .placeholder : [])
            }
        }
        .onAppear {
            viewModel.loadMovies()
            viewModel.showGenres()
        }
        .onChange(of: viewModel.state.selectedGenre) { _ in
            viewModel.selectMovies()
        }
    }
    
    //    // MARK: - Movie Card View
    private struct MovieCardView: View {
        var title: String
        var date: String
        var url: String?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                AsyncImage(url: URL(string:"\(Constants.Network.imageBaseURL)\(url ?? "")")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else if phase.error != nil || url == nil || url?.isEmpty == true {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                    } else {
                        ProgressView()
                    }
                }
                .frame(height: 180)
                .frame(maxWidth: .infinity)
                .clipped()
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(3)
                    .truncationMode(.middle)
                    .padding(.horizontal, 8)
                
                Text(date.yearOnly())
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
            }
            .frame(height: 260, alignment: .top)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.102, green: 0.102, blue: 0.102))
            .clipped()
            .padding(8)
        }
    }
}
