//
//  RegionCellViewModel.swift
//  Armnature
//
//  Created by Arthur on 6/21/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxCocoa
import RxSwift
import RxDataSources

final class RegionCellViewModel {
    
    struct Output {
        fileprivate(set) var name: Driver<String> = .never()
        fileprivate(set) var capital: Driver<String> = .never()
        fileprivate(set) var area: Driver<String> = .never()
        fileprivate(set) var population: Driver<String> = .never()
        fileprivate(set) var provinceImage: Driver<UIImage> = .never()
    }
    
    struct Dependency {
        let imageStore: ImageStore

        init(imageStore: ImageStore = SDWebImageStore()) {
            self.imageStore = imageStore
        }
    }
    
    private(set) var output = Output()

    init(province: Province, dependency: Dependency = Dependency()) {
        output.name = .just(province.name)
        
        output.capital = .just(province.capital == "" ? province.name : province.capital)
        
        output.area = .just(province.area)
        
        output.population = .just(province.population)
        
        output.provinceImage = dependency.imageStore.rx.fetch(with: province.image)
            .asDriver(onErrorDriveWith: .never())
    }
}
