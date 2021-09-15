//
//  ViewController.swift
//  EmployeeDetails
//
//  Created by Thejas K on 15/09/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemRed
        let firstView = UIView()
        firstView.frame = CGRect(x: self.view.bounds.width/2, y: self.view.bounds.height/2, width: 200, height: 50)
        firstView.backgroundColor = .systemBlue
        firstView.clipsToBounds = true
        firstView.layer.cornerRadius = 8
        firstView.center = self.view.center
        self.view.addSubview(firstView)
    }


}

