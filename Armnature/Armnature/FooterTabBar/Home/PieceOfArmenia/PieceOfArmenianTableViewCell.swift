//
//  PieceOfArmenianTableViewCell.swift
//  Armnature
//
//  Created by Arthur on 6/28/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa

class PieceOfArmenianTableViewCell: UITableViewCell {

    @IBOutlet weak var placeImage: UIImageView!
    
    var viewModel: PieceOfArmenianCellViewModel!
    private let disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    func configure(with viewModel: PieceOfArmenianCellViewModel) {
        self.viewModel = viewModel
        bindOutput()
    }

    private func bindOutput() {
        viewModel.output.placeImage
            .drive(placeImage.rx.image)
            .disposed(by: disposeBag)
    }
    
}
