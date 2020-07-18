//
//  SettingsViewController.swift
//  Armnature
//
//  Created by Arthur on 6/12/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import FirebaseAuth

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    var viewModel: SettingsViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.viewModel != nil {
            self.registerNibs()
            bindOutput()
        }        
    }
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<SettingsViewModel.Section>(
    configureCell: { [unowned self] _, table, indexPath, row in
        switch row {
        case .infoField(let fieldText, let infoText):
            let cell: SettingsTableViewCell = table.dequeueReusableCell(for: indexPath)
            let cellViewModel = SettingsTableCellViewModel(text: fieldText, field: infoText)
            cell.configure(with: cellViewModel)
            return cell
            }
        }
    )
    
    func configure(with viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    private func registerNibs() {
        let infoNib = UINib(nibName: SettingsTableViewCell.reuseIdentifier, bundle: nil)
        settingsTableView.register(infoNib, forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier)

    }

    private func bindOutput() {

        viewModel.output.sections
            .drive(settingsTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    @IBAction func clickOnLogoutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            UserData.clearCurrentUser()
        } catch  {
            print("error in logout")
        }
    }
    
}
