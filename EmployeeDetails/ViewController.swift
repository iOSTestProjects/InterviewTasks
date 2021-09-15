//
//  ViewController.swift
//  EmployeeDetails
//
//  Created by Thejas K on 15/09/21.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    var employeesArray : [Employee] = []
    var indexNumber : Int = 0

    @IBAction func searchButton(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    @IBOutlet weak var searchField: UITextField!
    let searchButton : UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchButton.frame = CGRect(x: self.view.bounds.width/2 + self.view.bounds.width/4, y: self.view.bounds.height/2 + self.view.bounds.height/3, width: 60, height: 60)
        searchButton.setTitle("•••", for: .normal)
        searchButton.setTitleColor(.systemOrange, for: .normal)
        searchButton.layer.cornerRadius = 30
        self.view.addSubview(searchButton)
        searchField.borderStyle = UITextField.BorderStyle.roundedRect
        populateEmployees()
    }
    
    // MARK: Data Handling methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "customViewController") as? CustomCellViewController else {
            fatalError("Error instantiating view controller")
        }
        vc.updateEmployeeProfile(indexNumber: indexNumber)
    }
    
    func populateEmployees() {
        let employ1 = Employee("Thejas", "K", "Amruthalli, Sahakar Nagar Post, Hebbal", "August 15th 1947", .male)
        let employ2 = Employee("Lakshmi", "K", "Vijaya Bank Layout, Bhannerughatta Road, Bangalore", "September 13th 2001", .female)
        let employ3 = Employee("Satoshi", "Nakamoto", "6th Cross, Avenue Road, Japan", "April 5th 1975", .male)
        let employ4 = Employee("Steve", "Jobs", "Silocon Valley, California", "February 24th 1955", .male)
        let employ5 = Employee("Sindhu", "P.V", "4th Street, Jubli Hills, Hyderabad", "July 5th 1995", .female)
        let employ6 = Employee("Nirmala", "Sitharaman", "8th Street, RR Nagar, Madurai", "August 18th 1959", .female)
        let employ7 = Employee("Cristiano", "Ronaldo", "Apple Ville, Portugal", "February 5th 1985", .male)
        let employ8 = Employee("Kamala", "Harris", "Oakland, California, U.S", "October 20th 1964", .female)
        let employ9 = Employee("Vladimir", "Putin", "Saint Petersburg, Russia", "October 7th 1952", .male)
        let employ10 = Employee("Rajneesh", "Osho", "Gadarwara, Madhya Pradesh", "December 11th 1931", .male)
        
        employeesArray.append(employ1)
        employeesArray.append(employ2)
        employeesArray.append(employ3)
        employeesArray.append(employ4)
        employeesArray.append(employ5)
        employeesArray.append(employ6)
        employeesArray.append(employ7)
        employeesArray.append(employ8)
        employeesArray.append(employ9)
        employeesArray.append(employ10)
        
        Employees.employees.append(employ1)
        Employees.employees.append(employ2)
        Employees.employees.append(employ3)
        Employees.employees.append(employ4)
        Employees.employees.append(employ5)
        Employees.employees.append(employ6)
        Employees.employees.append(employ7)
        Employees.employees.append(employ8)
        Employees.employees.append(employ9)
        Employees.employees.append(employ10)
        
        for employ in employeesArray {
            print("Employee Name : \(employ.firstName)")
        }
    }
    
    // MARK: Table view delegate methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCellIdentifier", for: indexPath) as? CustomCell else {
            fatalError("Error loading empty cell")
        }
        
        let index = indexPath.row
        
        if(index >= 0 && index < 10) {
            cell.cellFN?.text = employeesArray[index].firstName
            cell.cellLN?.text = employeesArray[index].lastName
            cell.cellDob?.text = employeesArray[index].dob
            cell.cellAddress?.text = employeesArray[index].address
            
            if(employeesArray[index].gender == Gender.male) {
                cell.cellGen?.text = "Male"
            } else {
                cell.cellGen?.text = "Female"
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        
        if(indexPath.row == 0) {
            print("1st cell tapped")
            
        } else if(indexPath.row == 1) {
            print("2nd cell tapped")
        } else if(indexPath.row == 2) {
            print("3rd cell tapped")
        } else if(indexPath.row == 3) {
            print("4th cell tapped")
        } else if(indexPath.row == 4) {
            print("5th cell tapped")
        } else if(indexPath.row == 5) {
            print("6th cell tapped")
        } else if(indexPath.row == 6) {
            print("7th cell tapped")
        } else if(indexPath.row == 7) {
            print("8th cell tapped")
        } else if(indexPath.row == 8) {
            print("9th cell tapped")
        } else if(indexPath.row == 9) {
            print("10th cell tapped")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
