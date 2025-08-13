//
//  Constants.swift
//  GeneralSwift
//
//  Created by ahmed gado on 12/08/2025.
//
import Foundation

public
enum Constants {
    public
    enum Network {
        public static let baseURL = "https://api.themoviedb.org/3/"
        public static let imageBaseURL = "https://image.tmdb.org/t/p/w500/"
        public static let movieURL = "discover/movie?include_adult=false&sort_by=popularity.desc&page="
    }

    public
    enum Color {
        public static let yellowColor = "#F5C519"
    }
}
