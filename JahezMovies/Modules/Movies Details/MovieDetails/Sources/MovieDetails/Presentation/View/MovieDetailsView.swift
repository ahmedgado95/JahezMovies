//
//  MovieDetailsView.swift
//  MovieDetails
//
//  Created by ahmed gado on 12/08/2025.
//

import SwiftUI
import GeneralSwift

public struct MovieDetailsView: View {
    @StateObject private var viewModel: MovieDetailsViewModel
    
    init(viewModel: MovieDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    public var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                RemoteImage(urlString: viewModel.posterURL ,
                            contentMode: .fit)
                HStack {
                    Button(action: {
                        viewModel.back()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.horizontal , 16)
                    }
                    
                    Spacer()
                    
                    ShareButton(activityItems: [viewModel.titleWithDate,
                                                viewModel.posterURL],
                                title: "Check out this movie!")

                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top, spacing: 12) {
                    RemoteImage(urlString: viewModel.posterURL)
                        .frame(width: 100, height: 150)
                        .cornerRadius(8)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(viewModel.titleWithDate)
                            .font(.headline)
                            .bold()
                        
                        Text(viewModel.genreNames)
                            .font(.subheadline)
                    }
                }
                
                Text(viewModel.state.movieDetails.overview)
                    .font(.headline)
                  .padding(.vertical)

                VStack(alignment: .leading, spacing: 8) {
                    
                    if let homeURL = URL(string: viewModel.state.movieDetails.homepage) {
                        HStack {
                            Text("Homepage: ")
                                .font(.headline)
                            if #available(iOS 16.0, *) {
                                Link(viewModel.state.movieDetails.homepage, destination: homeURL)
                                    .foregroundColor(.blue)
                                    .underline()
                            }
                        }
                    }
                    
                    HStack(alignment: .top) {
                        Text("Languages:")
                            .font(.headline)
                        Text(viewModel.languages)
                            .font(.subheadline)
                            .padding(.leading, 8)
                    }
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading){
                            HStack(){
                                Text("Status:")
                                    .font(.headline)
                                
                                Text(viewModel.state.movieDetails.status)
                                    .font(.subheadline)
                            }
                            HStack(){
                                
                                Text("Budget:")
                                    .font(.headline)
                                
                                Text("\(viewModel.state.movieDetails.budget) $")
                                    .font(.subheadline)
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading){
                            HStack(){
                                Text("Runtime:")
                                    .font(.headline)
                                
                                Text("\(viewModel.state.movieDetails.runtime) minutes")
                                    .font(.subheadline)
                            }
                            HStack(){
                                Text("Revenue:")
                                    .font(.headline)
                                
                                Text("\(viewModel.state.movieDetails.revenue) $")
                                    .font(.subheadline)
                            }
                        }
                        
                    }
                }
            }
            .padding()
        }
        .redacted(reason: viewModel.state.isLoading ? .placeholder : [])
        .onAppear {
          viewModel.showMovieDetails()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}
