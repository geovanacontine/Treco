//
//  ViewController.swift
//  SampleApp
//
//  Created by Pedro Contine on 16/02/22.
//

import UIKit
import Treco

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brandPure
        let button = TrecoTopAlert()
        button.render(withDTO: .init(message: "", style: .error, shouldAutoDismiss: true))
    }
}

 
