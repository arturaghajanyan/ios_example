//
//  mapTo.swift
//  Armnature
//
//  Created by Arthur on 6/17/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {

    /**
    Returns an observable sequence containing as many elements as its input but all of them are the constant provided as a parameter
    
    - parameter value: A constant that each element of the input sequence is being replaced with
    - returns: An observable sequence containing the values `value` provided as a parameter
    */
    public func mapTo<Result>(_ value: Result) -> Observable<Result> {
        return map { _ in value }
    }
}

extension PrimitiveSequence where Trait == SingleTrait {
    /**
     Returns a Single which success event is mapped to constant provided as a parameter

     - parameter value: A constant that element of the input sequence is being replaced with
     - returns: A Single containing the value `value` provided as a parameter in case of success
     */
    public func mapTo<Result>(_ value: Result) -> Single<Result> {
        return map { _ in value }
    }
}

extension PrimitiveSequence where Trait == MaybeTrait {
    /**
     Returns a Maybe which success event is mapped to constant provided as a parameter

     - parameter value: A constant that element of the input sequence is being replaced with
     - returns: A Maybe containing the value `value` provided as a parameter in case of success
     */
    public func mapTo<Result>(_ value: Result) -> Maybe<Result> {
        return map { _ in value }
    }
}
