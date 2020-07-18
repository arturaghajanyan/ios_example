//
//  CitiesInRegionsCellViewModel.swift
//  Armnature
//
//  Created by Arthur on 7/4/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources

final class CitiesInRegionsCellViewModel {
    
    struct Input {
        let playProvince = PublishRelay<Void>()
    }
    
    struct Output {
        fileprivate(set) var titleText: Driver<String> = .never()
        fileprivate(set) var provinceImage: Driver<UIImage> = .never()
        fileprivate(set) var playProvince: Signal<CitiesInRegions> = .never()
    }

    struct Dependency {
        let imageStore: ImageStore

        init(imageStore: ImageStore = SDWebImageStore()) {
            self.imageStore = imageStore
        }
    }
    
    let input: Input = Input()
    private(set) var output: Output = Output()
    
    init(city: CitiesInRegions, dependency: Dependency = Dependency()) {
        output.titleText = .just(city.name)
        
        output.provinceImage = dependency.imageStore.rx.fetch(with: city.image)
            .asDriver(onErrorDriveWith: .never())
        
        output.playProvince = input.playProvince
            .withLatestFrom(Observable.just(city))
            .asSignal(onErrorSignalWith: .never())

    }
}
