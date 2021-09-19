//
//  DetailViewController.swift
//  EmployeeDetails
//
//  Created by Thejas K on 16/09/21.
//

import UIKit

class DetailViewController: UIViewController {

    var employ : Employee? = nil
    
    @IBOutlet weak var firstNameLabel: UILabel?
    @IBOutlet weak var lastNameLabel: UILabel?
    @IBOutlet weak var dobLabel: UILabel?
    @IBOutlet weak var genderLabel: UILabel?
    @IBOutlet weak var addressLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameLabel?.text = employ?.firstName
        lastNameLabel?.text = employ?.lastName
        dobLabel?.text = employ?.dob
        addressLabel?.text = "Address : \n\n\(String(describing: employ!.address))"
        
        if(employ?.gender == .male) {
            genderLabel?.text = "Male"
        } else {
            genderLabel?.text = "Female"
        }
    }
}
