//
//  HomeViewModel.swift
//  Armnature
//
//  Created by Arthur on 5/29/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class HomeViewModel {
    typealias Section = AnimatableSectionModel<String, Row>

    enum Row: Equatable, IdentifiableType {
        static func == (lhs: HomeViewModel.Row, rhs: HomeViewModel.Row) -> Bool {
            true
        }
        case title(String)
        case place(URL)
        case videoLooper(URL)
        case interestingInfo(obj: InterestingInfo)
        case interestingToVisitInfo(obj: VisitToArmenia)
        var identity: String {
            String(describing: self)
        }
    }
    
    struct Output {
        fileprivate(set) var titleText: Driver<String> = .never()
        fileprivate(set) var sections: Driver<[Section]> = .never()
        fileprivate(set) var videoLooperUrl: Driver<URL> = .never()
    }
    
    private(set) var output: Output = Output()

    init(homeData: HomeData) {
        output.titleText = .just(homeData.title)
        
        output.sections = Driver.just(homeData)
            .map { _ in
                var sections: [Section] = []
                var rows: [HomeViewModel.Row] = []
                
                rows.append(Row.videoLooper(homeData.videoLooperUrl))
                
                if let infoComponent = homeData.interestingInfoComponent {
                    rows.append(Row.title(infoComponent.headlineText))
                    rows.append(Row.interestingInfo(obj: infoComponent))
                }
                
                if let infotoVisitComponent = homeData.visitToArmenianComponent {
                    rows.append(Row.title(infotoVisitComponent.headlineText))
                    rows.append(Row.interestingToVisitInfo(obj: infotoVisitComponent))
                }
                
                if let placeObject = homeData.pieceOfArmeniaWithYouComponent {
                    rows.append(Row.title(placeObject.title))
                    let resourceRows = placeObject.images.map { Row.place($0) }
                    rows.append(contentsOf: resourceRows)
                }
                
                sections.append(Section(model: "", items: rows))
                return sections
            }
    }
}

