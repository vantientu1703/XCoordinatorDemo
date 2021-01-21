//
//  IntroViewController.swift
//  XCoordinatorDemo
//
//  Created by Van Tien Tu on 22/01/2021.
//

import UIKit
import RxSwift

class IntroViewController: UIViewController {

    var viewModel: IntroViewModel!
    
    private let viewAppearTriggered = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("[info] inited IntroViewController")
        self.bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewAppearTriggered.onNext(())
    }
    
    func bindViewModel() {
        let input = IntroViewModel.Input(viewDidAppear: self.viewAppearTriggered.asObservable())
        let _ = self.viewModel.transform(input)
    }
    
    deinit {
        print("[info] deinited IntroViewController")
    }
}
