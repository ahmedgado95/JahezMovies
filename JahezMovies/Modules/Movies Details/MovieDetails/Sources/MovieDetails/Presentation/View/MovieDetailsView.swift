//
//  MovieDetailsView.swift
//  MovieDetails
//
//  Created by ahmed gado on 12/08/2025.
//

import SwiftUI
import GeneralSwift

struct MovieDetailsView: View {
    @StateObject private var viewModel: MovieDetailsViewModel
    
    init(viewModel: MovieDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        var url: String?
        ScrollView {
            ZStack(alignment: .top) {
                RemoteImage(urlString: "\(Constants.Network.imageBaseURL)\(url)")
                    .scaledToFill()
                
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
                    
                    Button(action: {
                        print("Share button tapped!")
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(.horizontal , 16)
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top, spacing: 12) {
                    RemoteImage(urlString: "\(Constants.Network.imageBaseURL)\(url)")
                        .frame(width: 100, height: 150)
                        .cornerRadius(8)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("title")
                            .font(.title)
                            .bold()
                        
                        Text("details")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    if let homeURL = URL(string: url ?? "homeURL") {
                        HStack {
                            Text("Homepage: ")
                                .font(.headline)
                            if #available(iOS 16.0, *) {
                                Link("homeURL", destination: homeURL)
                                    .foregroundColor(.blue)
                                    .underline()
                            }
                        }
                    }
                    
                    HStack(alignment: .top) {
                        Text("Languages:")
                            .font(.headline)
                        Text("languages")
                            .font(.subheadline)
                            .padding(.leading, 8)
                    }
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading){
                            HStack(){
                                Text("Status:")
                                    .font(.headline)
                                
                                Text("status")
                                    .font(.subheadline)
                            }
                            HStack(){
                                
                                Text("Budget:")
                                    .font(.headline)
                                
                                Text("\("budget") $")
                                    .font(.subheadline)
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading){
                            HStack(){
                                Text("Runtime:")
                                    .font(.headline)
                                
                                Text("\("runtime" ) minutes")
                                    .font(.subheadline)
                            }
                            HStack(){
                                Text("Revenue:")
                                    .font(.headline)
                                
                                Text("\("revenue") $")
                                    .font(.subheadline)
                            }
                        }
                        
                    }
                }
            }
            .padding()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}
