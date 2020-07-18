//
//  InterestingToVisitCellViewModel.swift
//  Armnature
//
//  Created by Arthur on 6/28/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources

final class InterestingToVisitCellViewModel {

    struct Output {
        fileprivate(set) var descriptionText: Driver<String> = .never()
        fileprivate(set) var titleText: Driver<String> = .never()
        fileprivate(set) var infoImage: Driver<UIImage> = .never()
    }

    struct Dependency {
        let imageStore: ImageStore

        init(imageStore: ImageStore = SDWebImageStore()) {
            self.imageStore = imageStore
        }
    }
    
    private(set) var output: Output = Output()
    
    init(infoObject: InterestingInfoObjects, dependency: Dependency = Dependency()) {
        output.descriptionText = .just(infoObject.description)
        
        if let titletext = infoObject.title {
            output.titleText = .just(titletext)
        }
        
        output.infoImage = dependency.imageStore.rx.fetch(with: infoObject.image)
            .asDriver(onErrorDriveWith: .never())
    }
    
}

