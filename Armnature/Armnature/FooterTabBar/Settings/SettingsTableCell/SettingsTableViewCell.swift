//
//  SettingsTableViewCell.swift
//  Armnature
//
//  Created by Arthur on 6/28/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var fieldLabel: UILabel!

    var viewModel: SettingsTableCellViewModel!
    private let disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    func configure(with viewModel: SettingsTableCellViewModel) {
        self.viewModel = viewModel
        bindOutput()
    }

    private func bindOutput() {
        viewModel.output.infoText
            .drive(infoLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.fieldText
            .drive(fieldLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}
