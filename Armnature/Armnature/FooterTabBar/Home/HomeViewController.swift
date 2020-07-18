//
//  HomeViewController.swift
//  Armnature
//
//  Created by Arthur on 5/27/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import FirebaseAuth
import AVFoundation

class HomeViewController: UIViewController {
    var forReuse = true
    private var playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    private var interestingCollectionViewController: InterestingCollectionViewController!
    private var interestingToVisitCollectionViewController: InterestingToVisitCollectionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.viewModel != nil {
            let storyBoard : UIStoryboard = UIStoryboard(name: "InterestingCollectionView", bundle:nil)
            self.interestingCollectionViewController = storyBoard.instantiateViewController(withIdentifier: "InterestingCollectionViewController")
            let storyBoardVisit : UIStoryboard = UIStoryboard(name: "InterestingToVisitCollectionView", bundle:nil)
            self.interestingToVisitCollectionViewController = storyBoardVisit.instantiateViewController(withIdentifier: "InterestingToVisitCollectionViewController")
            self.registerNibs()
            bindOutput()
        }
    }
    
    func configure(with viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    
   private lazy var dataSource = RxTableViewSectionedReloadDataSource<HomeViewModel.Section>(
    configureCell: { [unowned self] _, table, indexPath, row in
        switch row {
        case .title(let titleText):
            let cell: TitleTableViewCell = table.dequeueReusableCell(for: indexPath)
            let cellViewModel = TitleCellViewModel(text: titleText)
            cell.configure(with: cellViewModel)
            return cell
        case .videoLooper(let url):
            let cell: VideoLooperTableViewCell = table.dequeueReusableCell(for: indexPath)
            let cellViewModel = VideoLooperCellViewModel(videoUrl: url)
            cell.configure(with: cellViewModel)
            return cell
        case .interestingInfo(let obj):
            let cell: InterestingInfoTableViewCell = table.dequeueReusableCell(for: indexPath)
            let cellViewModel = InterestingInfoCellViewModel(interestingInfo: obj)
            self.interestingCollectionViewController.viewModel = InterestingCollectionViewModel(interestingInfoObjects: obj.interesting)
            cell.collectionViewController = self.interestingCollectionViewController
            cell.configure(with: cellViewModel)
            return cell
        case .interestingToVisitInfo(let objToVisit):
            let cell: InterestingToVisitTableViewCell = table.dequeueReusableCell(for: indexPath)
            let cellViewModel = InterestingToVisitTableCellViewModel(visitToInfo: objToVisit)
            self.interestingToVisitCollectionViewController.viewModel = InterestingToVisitCollectionViewModel(interestingInfoObjects: objToVisit.interesting)
            cell.collectionViewController = self.interestingToVisitCollectionViewController
            cell.configure(with: cellViewModel)
            return cell
        case .place(let url):
            let cell: PieceOfArmenianTableViewCell = table.dequeueReusableCell(for: indexPath)
            let cellViewModel = PieceOfArmenianCellViewModel(url: url)
            cell.configure(with: cellViewModel)
            return cell
            }
        }
    )
    
    private func registerNibs() {
        let videoLooperNib = UINib(nibName: VideoLooperTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(videoLooperNib, forCellReuseIdentifier: VideoLooperTableViewCell.reuseIdentifier)
        
        let interestingInfoNib = UINib(nibName: InterestingInfoTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(interestingInfoNib, forCellReuseIdentifier: InterestingInfoTableViewCell.reuseIdentifier)
        
        let interestingToVosotInfoNib = UINib(nibName: InterestingToVisitTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(interestingToVosotInfoNib, forCellReuseIdentifier: InterestingToVisitTableViewCell.reuseIdentifier)
        
        let titleCellNib = UINib(nibName: TitleTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(titleCellNib, forCellReuseIdentifier: TitleTableViewCell.reuseIdentifier)
        
        let placeCellNib = UINib(nibName: PieceOfArmenianTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(placeCellNib, forCellReuseIdentifier: PieceOfArmenianTableViewCell.reuseIdentifier)
    }

    private func bindOutput() {
        viewModel.output.titleText
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.sections
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }

}
