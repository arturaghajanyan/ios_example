//
//  TitleTableViewCell.swift
//  Armnature
//
//  Created by Arthur on 6/28/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: TitleCellViewModel!
    private let disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    func configure(with viewModel: TitleCellViewModel) {
        self.viewModel = viewModel
        bindOutput()
    }

    private func bindOutput() {
        viewModel.output.titleText
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}
