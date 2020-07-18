//
//  ForgotPasswordViewController.swift
//  Armnature
//
//  Created by Arthur on 5/26/20.
//  Copyright © 2020 Arthur. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var backIcon: UIButton!
    
    var viewModel: ForgotPasswordViewModel!
    private let disposeBag = DisposeBag()
    
    func configure(with viewModel: ForgotPasswordViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindOutput()
        bindInput()
    }
    
    private func bindOutput() {
       viewModel.output.titleText
           .drive(titleLabel.rx.text)
           .disposed(by: disposeBag)
       
       viewModel.output.sendMessageButtonText
           .drive(sendMessageButton.rx.title())
           .disposed(by: disposeBag)
        
        viewModel.output.showSignInPage
            .emit(onNext: { [unowned self] _ in
                self.clickOnBackIcon()
            })
            .disposed(by: disposeBag)
    }

    private func bindInput() {
        backIcon.rx.tap
            .bind(to: viewModel.input.selectBackIcon)
            .disposed(by: disposeBag)
    }
    
    private func clickOnBackIcon() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Signin", bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "SigninViewController") as! SigninViewController
        viewController.viewModel = SigninViewModel(data: SignDataBuilder.createSignInPageData())
        viewController.modalPresentationStyle = .fullScreen
        show(viewController, sender: nil)
    }
    
}
