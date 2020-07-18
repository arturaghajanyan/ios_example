//
//  PieceOfArmenianCellViewModel.swift
//  Armnature
//
//  Created by Arthur on 6/28/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources

final class PieceOfArmenianCellViewModel {
    
    struct Output {
        fileprivate(set) var placeImage: Driver<UIImage> = .never()
    }
    
    struct Dependency {
        let imageStore: ImageStore

        init(imageStore: ImageStore = SDWebImageStore()) {
            self.imageStore = imageStore
        }
    }
    
    private(set) var output = Output()

    init(url: URL, dependency: Dependency = Dependency()) {
        output.placeImage = dependency.imageStore.rx.fetch(with: url)
            .asDriver(onErrorDriveWith: .never())
    }
    
}
