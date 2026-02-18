//
//  CachedAsyncImage.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 18/2/2026.
//

import Foundation
import SwiftUI

struct CachedAsyncImage<Content: View, Placeholder: View>: View {
    let url: URL
    let content: (Image) -> Content
    let placeholder: () -> Placeholder
    
    @State private var cachedImage: UIImage?
    
    init(
        url: URL,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.content = content
        self.placeholder = placeholder
    }
    
    var body: some View {
        Group {
            if let cachedImage {
                content(Image(uiImage: cachedImage))
            } else {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case let .success(image):
                        // TODO: Remove this from code, so there's no side-effect for success state in the view
                        saveToCache(from: url)
                        return AnyView(content(image))
                    case .failure, .empty:
                        return AnyView(placeholder())
                    @unknown default:
                        return AnyView(placeholder())
                    }
                }
            }
        }
        .onAppear {
            loadFromCache()
        }
    }
    
    private func loadFromCache() {
        if let loadedImage = ImageCache.shared.object(forKey: url as NSURL) {
            cachedImage = loadedImage
        }
    }

    private func saveToCache(from url: URL) {
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let uiImage = UIImage(data: data),
                   cachedImage == nil {
                    ImageCache.shared.setObject(uiImage, forKey: url as NSURL)
                    cachedImage = uiImage
                }
            } catch {
                print("Image caching failed: \(error)")
            }
        }
    }
}
