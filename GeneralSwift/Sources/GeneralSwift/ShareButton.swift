//
//  ShareButton.swift
//  GeneralSwift
//
//  Created by ahmed gado on 14/08/2025.
//

import SwiftUI
import SwiftUI

// Make the ShareButton struct and its initializer public.
public struct ShareButton: View {
    public var activityItems: [Any]
    public var title: String?
    
    @State private var showShareSheet = false
    
    public var body: some View {
        Button(action: {
            showShareSheet.toggle()
        }) {
            Image(systemName: "square.and.arrow.up")
                .font(.title)
                .foregroundColor(.white)
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: activityItems)
        }
    }
    
    public init(activityItems: [Any], title: String? = nil) {
        self.activityItems = activityItems
        self.title = title
    }
}

// Make the ShareSheet struct public as well.
public struct ShareSheet: UIViewControllerRepresentable {
    public var activityItems: [Any]

    public func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil
        )
        return activityViewController
    }

    public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No update needed
    }
}
