//
//  ViewController.swift
//  EmployeeDetails
//
//  Created by Thejas K on 15/09/21.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate {
    // MARK: Declarations
    @IBOutlet weak var employeeTableView: UITableView?
    var employeesArray : [Employee] = []
    var filteredArray : [Employee] = []
    var isFiltered : Bool = false
    var indexNumber : Int = 0
    
    @IBOutlet weak var searchField: UITextField?
    let searchButton : UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        return button
    }()

    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.frame = CGRect(x: self.view.bounds.width/2 + self.view.bounds.width/4, y: self.view.bounds.height/2 + self.view.bounds.height/3, width: 60, height: 60)
        searchButton.setTitle("•••", for: .normal)
        searchButton.setTitleColor(.systemOrange, for: .normal)
        searchButton.layer.cornerRadius = 30
        searchButton.setImage(UIImage(named: "filterImage"), for: .normal)
        searchButton.contentMode = .scaleToFill
        self.view.addSubview(searchButton)
        populateEmployees()
    }
    
    // MARK: Data Handling Methods
    
    func populateEmployees() {
        let employ1 = Employee("Thejas", "K", "Amruthalli, Sahakar Nagar Post, Hebbal", "August 15th 1947", .male)
        let employ2 = Employee("Lakshmi", "K", "Vijaya Bank Layout, Bhannerughatta Road, Bangalore", "September 13th 2001", .female)
        let employ3 = Employee("Satoshi", "Nakamoto", "6th Cross, Avenue Road, Japan", "April 5th 1975", .male)
        let employ4 = Employee("Steve", "Jobs", "Silocon Valley, California", "February 24th 1955", .male)
        let employ5 = Employee("Sindhu", "Sitharaman", "4th Street, Jubli Hills, Hyderabad", "July 5th 1995", .female)
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
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        view.endEditing(true)
        
        self.updateTable()
        
        print("The number of elements in filtered array : \(filteredArray.count)")
        
        if(searchField?.text == "") {
            isFiltered = false
            self.employeeTableView?.reloadData()
        } else {
            isFiltered = true
            self.employeeTableView?.reloadData()
        }
    }
    
    func updateTable() {
        let error = "Attempt was made to add duplicate employ record to the filtered array"
        
        for employ in employeesArray {
            
            if(searchField?.text == employ.firstName || searchField?.text == employ.lastName || searchField?.text == employ.dob || searchField?.text == employ.address) {
                if(filteredArray.count > 0) {
                    for filterEmploy in filteredArray {
                        if(filterEmploy.firstName != employ.firstName || filterEmploy.lastName != employ.lastName || filterEmploy.address != employ.address || filterEmploy.dob != employ.dob) {
                            
                            if(filterEmploy.firstName == employ.firstName || filterEmploy.lastName == employ.lastName || filterEmploy.address == employ.address || filterEmploy.dob == employ.dob) {
                                filteredArray.append(Employee(employ.firstName, employ.lastName, employ.address, employ.dob, employ.gender))
                                break
                            } else {
                                filteredArray.removeAll()
                                filteredArray.append(Employee(employ.firstName, employ.lastName, employ.address, employ.dob, employ.gender))
                                break
                            }
                        } else {
                            print(error)
                        }
                    }
                } else {
                    //filteredArray.removeAll()
                    filteredArray.append(Employee(employ.firstName, employ.lastName, employ.address, employ.dob, employ.gender))
                }
            }
        }
    }
    
    // MARK: Table View Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltered ? filteredArray.count : employeesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCellIdentifier", for: indexPath) as? CustomCell else {
            fatalError("Error loading empty cell")
        }
        
        let index = indexPath.row
        
        if(index >= 0 && index < 10) {
            
            if(isFiltered == true) {
                cell.cellFN?.text = filteredArray[index].firstName
                cell.cellLN?.text = filteredArray[index].lastName
                cell.cellDob?.text = filteredArray[index].dob
                cell.cellAddress?.text = filteredArray[index].address
                
                if(filteredArray[index].gender == Gender.male) {
                    cell.cellGen?.text = "Male"
                } else {
                    cell.cellGen?.text = "Female"
                }
            } else {
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
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "customViewController") as? DetailViewController else {
            fatalError("Error loading detail view")
        }
        
        if(isFiltered == true) {
            detailVC.employ = Employee(filteredArray[indexPath.row].firstName, filteredArray[indexPath.row].lastName, filteredArray[indexPath.row].address, filteredArray[indexPath.row].dob, filteredArray[indexPath.row].gender)
        } else {
            detailVC.employ = Employee(employeesArray[indexPath.row].firstName, employeesArray[indexPath.row].lastName, employeesArray[indexPath.row].address, employeesArray[indexPath.row].dob, employeesArray[indexPath.row].gender)
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    // MARK: UIText Field Delegate Methods
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text == "") {
            isFiltered = false
            self.employeeTableView?.reloadData()
        } else {
            isFiltered = true
            self.employeeTableView?.reloadData()
        }
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {

        isFiltered = false
        self.employeeTableView?.reloadData()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if(textField.text == "") {
            isFiltered = false
            self.employeeTableView?.reloadData()
        } else {
            self.updateTable()
            isFiltered = true
            self.employeeTableView?.reloadData()
        }
        view.endEditing(true)
        return true
    }
    
}
