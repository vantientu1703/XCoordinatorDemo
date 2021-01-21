//
//  ViewController.swift
//  XCoordinatorDemo
//
//  Created by Van Tien Tu on 21/01/2021.
//

import UIKit
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var presentButton: UIButton!
    @IBOutlet weak var pushButton: UIButton!
    
    var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("[info] inited ViewController")
        self.bindViewModel()
    }
    
    func bindViewModel() {
        let input = MainViewModel.Input(presentTriggered: self.presentButton.rx.tap.asObservable(),
                                        pushTriggered: self.pushButton.rx.tap.asObservable())
//        self.pushButton.rx.tap.asObservable()
//            .subscribe { (_) in
//                print("")
//            }
            
        let _ = self.viewModel.transform(input)
    }
    
    deinit {
        print("[info] deinited ViewController")
    }
}
