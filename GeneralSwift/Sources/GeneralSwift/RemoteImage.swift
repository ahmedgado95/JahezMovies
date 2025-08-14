//
//  RemoteImage.swift
//  GeneralSwift
//
//  Created by ahmed gado on 14/08/2025.
//

import SwiftUI

public struct RemoteImage: View {
    let urlString: String?
    let contentMode: ContentMode
    let placeholder: Image

    public init(urlString: String?,
         contentMode: ContentMode = .fill,
         placeholder: Image = Image(systemName: "photo")
        ) {
        self.urlString = urlString
        self.contentMode = contentMode
        self.placeholder = placeholder
    }

    public var body: some View {
        AsyncImage(url: URL(string: urlString ?? "")) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            case .failure(_):
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .foregroundColor(.gray)
            @unknown default:
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                    .foregroundColor(.gray)
            }
        }
    }
}
