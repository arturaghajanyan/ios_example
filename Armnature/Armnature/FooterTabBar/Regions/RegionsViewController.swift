//
//  RegionsViewController.swift
//  Armnature
//
//  Created by Arthur on 6/21/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import FirebaseAuth

class RegionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: RegionsViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNibs()
        bindOutput()
        bindInput()
    }
    
    func configure(with viewModel: RegionsViewModel) {
        self.viewModel = viewModel
    }

   private lazy var dataSource = RxTableViewSectionedReloadDataSource<RegionsViewModel.Section>(
    configureCell: { [unowned self] _, table, indexPath, row in
        switch row {
            case .province(let province):
                let cell: RegionTableViewCell = table.dequeueReusableCell(for: indexPath)
                let cellViewModel = RegionCellViewModel(province: province)
                cell.configure(with: cellViewModel)
                return cell
            }
        }
    )
    
    private func registerNibs() {
        let resourceNib = UINib(nibName: RegionTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(resourceNib, forCellReuseIdentifier: RegionTableViewCell.reuseIdentifier)
    }

    private func bindOutput() {
        viewModel.output.titleText
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.output.showResourcePreview
            .emit(onNext: { [unowned self] province in
                self.showCitiesInRegions(cities: province.cities)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindInput() {
        tableView.rx.modelSelected(RegionsViewModel.Row.self)
            .bind(to: viewModel.input.selectRow)
            .disposed(by: disposeBag)
    }
    
    private func showCitiesInRegions(cities: [CitiesInRegions]){
        let storyboard = UIStoryboard(name: "CitiesInRegions", bundle: nil)
        guard let citiesViewController = storyboard.instantiateViewController(withIdentifier: "CitiesInRegionsViewController") as? CitiesInRegionsViewController else { return }
        citiesViewController.configure(with: CitiesInRegionsViewModel(cities: cities))
        citiesViewController.view.backgroundColor = .green
        show(citiesViewController, sender: nil)
    }

}
