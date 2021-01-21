//
//  SecondViewController.swift
//  XCoordinatorDemo
//
//  Created by Van Tien Tu on 21/01/2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var presentButton: UIButton!
    
    var viewModel: SecondViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        print("[info] inited SecondViewController")
    }
    
    func bindViewModel() {
        let input = SecondViewModel.Input(dismissTriggered: self.dismissButton.rx.tap.asObservable(),
                                          presentTriggered: self.presentButton.rx.tap.asObservable())
        let _ = self.viewModel.transform(input)
    }
    
    deinit {
        print("[info] deinited SecondViewController")
    }
}
