//
//  VideoLooperCellViewModel.swift
//  Armnature
//
//  Created by Arthur on 6/27/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa

final class VideoLooperCellViewModel {

    struct Output {
        fileprivate(set) var videoLooperUrl: Driver<URL> = .never()
    }
    
    private(set) var output: Output = Output()

    init(videoUrl: URL) {
        output.videoLooperUrl = .just(videoUrl)
    }
    
}
