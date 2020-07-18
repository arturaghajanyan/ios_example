//
//  HomeDataModel.swift
//  Armnature
//
//  Created by Arthur on 6/22/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import Foundation

struct InterestingInfoObjects: Codable {
    let image: URL
    let title: String?
    let description: String
}

struct InterestingInfo: Equatable {
    static func == (lhs: InterestingInfo, rhs: InterestingInfo) -> Bool {
        true
    }
    let headlineText: String
    let interesting: [InterestingInfoObjects]
}

struct VisitToArmenia: Equatable {
    static func == (lhs: VisitToArmenia, rhs: VisitToArmenia) -> Bool {
        true
    }
    let headlineText: String
    let description: String
    let interesting: [InterestingInfoObjects]
}

struct ArmenianNatureForHealth: Equatable {
    static func == (lhs: ArmenianNatureForHealth, rhs: ArmenianNatureForHealth) -> Bool {
        true
    }
    let headlineText: String
    let image: URL
    let description: String
}

struct PieceOfArmeniaWithYou: Equatable {
    static func == (lhs: PieceOfArmeniaWithYou, rhs: PieceOfArmeniaWithYou) -> Bool {
        true
    }
    let title: String
    let images: [URL]
}

struct HomeData: Equatable {
    let title: String
    let videoLooperUrl: URL
    let interestingInfoComponent: InterestingInfo?
    let visitToArmenianComponent: VisitToArmenia?
    let pieceOfArmeniaWithYouComponent: PieceOfArmeniaWithYou?
    
}
