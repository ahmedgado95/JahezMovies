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
        NavigationView {
            VStack {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: viewModel.columnsGrids,
                              spacing: 4) {
                        ForEach($viewModel.movies, id: \.self) { movie in
                            MovieCardView(title: movie,
                                          date: "2025",
                                          url: "https://fastly.picsum.photos/id/237/200/300.jpg?hmac=TmmQSbShHz9CdQm0NkEjx1Dyh_Y984R9LpNrpvH2D_U")
                        }
                    }
                }
            }
            .navigationTitle("Watch New Movies")
        }
    }
}

private struct MovieCardView: View {
    @Binding  var title: String
    @State var date: String
    @State var url: String?
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: url ?? "")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error != nil || url == nil || url?.isEmpty == true {
                    Image("arrow.2.circlepath.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else {
                    ProgressView()
                }
            }
            .frame(height: 180)
            .clipped()
            
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(4)
            
            Text(date)
                .font(.caption)
                .foregroundColor(.white)
                .padding(4)
        }
        .frame(maxWidth: .infinity)
        .background(Color(red: 0.102, green: 0.102, blue: 0.102))
        .padding(8)
    }
    
}
#Preview {
    MoviesView(viewModel: MoviesViewModel())
}
