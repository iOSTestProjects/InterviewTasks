//
//  CustomCell.swift
//  EmployeeDetails
//
//  Created by Thejas K on 15/09/21.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var cellFN: UILabel?
    @IBOutlet weak var cellLN: UILabel?
    @IBOutlet weak var cellGen: UILabel?
    @IBOutlet weak var cellDob: UILabel?
    @IBOutlet weak var cellAddress: UILabel?

}

class CustomCellViewController : UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView?
    
    @IBOutlet weak var firstNameLabel: UILabel?
    @IBOutlet weak var lastNameLabel: UILabel?
    @IBOutlet weak var dobLabel: UILabel?
    @IBOutlet weak var genderLabel: UILabel?
    @IBOutlet weak var addressLabel: UILabel?
    
    func updateEmployeeProfile(indexNumber : Int)  {
        
    }
}
