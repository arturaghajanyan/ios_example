//
//  ImageExtension.swift
//  Armnature
//
//  Created by Arthur on 6/19/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage.SDWebImageDownloader
import SDWebImage.SDImageCache
import RxSwift

enum ImageStoreError: Error {
    case imageDownloadFailed
}

public protocol ImageStore {
    typealias FetchCompletion = ((Result<UIImage, Error>) -> Void)
    typealias CacheCompletion = (() -> Void)
    func fetchImage(with url: URL?, completion: FetchCompletion?)
    func cache(image: UIImage, at url: String, toDisk: Bool, completion: CacheCompletion?)
}

final class SDWebImageStore: ImageStore {
    var imageDownloader: SDWebImageDownloader
    var imageCache: SDImageCache
    
    init(imageDownloader: SDWebImageDownloader = .shared, imageCache: SDImageCache = .shared) {
        self.imageDownloader = imageDownloader
        self.imageCache = imageCache
    }
    
    func fetchImage(with url: URL?, completion: FetchCompletion?) {
        if let cachedImage = imageCache.imageFromCache(forKey: url?.absoluteString) {
            completion?(.success(cachedImage))
        } else {
            imageDownloader.downloadImage(with: url, options: [], progress: nil) { (image, _, error, _) in
                if let image = image {
                    self.imageCache.store(image, forKey: url?.absoluteString, completion: nil)
                    completion?(.success(image))
                } else {
                    completion?(.failure(error ?? ImageStoreError.imageDownloadFailed))
                }
            }
        }
    }
    
    func cache(image: UIImage, at url: String, toDisk: Bool, completion: CacheCompletion?) {
        self.imageCache.store(image, forKey: url, toDisk: toDisk, completion: completion)
    }
}

public final class RxImageStore: ReactiveCompatible {
    fileprivate let store: ImageStore
    fileprivate init(_ store: ImageStore) {
        self.store = store
    }
}

public extension ImageStore {
    var rx: Reactive<RxImageStore> {
        return RxImageStore(self).rx
    }
}

extension Reactive where Base: RxImageStore {
    func fetch(with url: URL?) -> Single<UIImage> {
        return .create { observer in
            self.base.store.fetchImage(with: url) { result in
                switch result {
                case .success(let image):
                    observer(.success(image))
                case .failure(let error):
                    observer(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func cache(image: UIImage, at url: String, toDisk: Bool) -> Completable {
        return .create { observer in
            self.base.store.cache(image: image, at: url, toDisk: toDisk) {
                observer(.completed)
            }
            return Disposables.create()
        }
    }
}

extension UIImageView {
    func dropShadow(color: CGColor) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color
        self.layer.shadowOpacity = 0.7
        self.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.layer.shadowRadius = 3
    }
}
