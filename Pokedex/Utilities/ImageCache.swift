//
//  ImageCache.swift
//  Pokedex
//
//  Created by Jerome Rodriguez on 18/2/2026.
//

import Foundation
import UIKit

final class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()

    private init() {
        ImageCache.shared.countLimit = 100
        ImageCache.shared.totalCostLimit = 50 * 1024 * 1024
    }
}
