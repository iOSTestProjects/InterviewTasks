//
//  ViewController.swift
//  EmployeeDetails
//
//  Created by Thejas K on 15/09/21.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UITextFieldDelegate, UIPopoverPresentationControllerDelegate {
    // MARK: Declarations
    @IBOutlet weak var employeeTableView: UITableView?
    var employeesArray : [Employee] = []
    var filteredArray : [Employee] = []
    var isFiltered : Bool = false
    var searchAlert : Bool = false
    var popOverController = UIAlertController()
    
    @IBOutlet weak var searchField: UITextField?
    let filterButton : UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGroupedBackground
        return button
    }()

    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        filterButton.layer.cornerRadius = 35
        filterButton.setImage(UIImage(named: "filterImage"), for: .normal)
        filterButton.contentMode = .scaleToFill
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        self.view.addSubview(filterButton)
        
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height/1.2),
            filterButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -50),
            filterButton.widthAnchor.constraint(equalToConstant: 70),
            filterButton.heightAnchor.constraint(equalToConstant: 70)
        ])
        populateEmployees()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
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
        let warning = "Attempt was made to add duplicate employ record to the filtered array"
        
        // 1. Make the data model to conform to Equatable protocol and equate with one word rather than all the record details
        // 2. It also helps in appending array elements with one word
        // 3. Minimise the if else ladder properly by grouping conditions with && and ||
        
        for employ in employeesArray {
            
            if(searchField?.text == employ.firstName || searchField?.text == employ.lastName || searchField?.text == employ.dob || searchField?.text == employ.address) {
                searchAlert = true
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
                            print(warning)
                            return
                        }
                    }
                } else {
                    //filteredArray.removeAll()
                    filteredArray.append(Employee(employ.firstName, employ.lastName, employ.address, employ.dob, employ.gender))
                }
            } else {
                print("Error : Invalid record details entered")
            }
        }
        
        if(searchAlert == false) {
            popTheInvalidRecordAlert()
        }
    }
    
    func popTheInvalidRecordAlert() {
        let wrongRecordAlert = UIAlertController(title: "Invalid Employee!", message: "Please enter a valid employee details. Employee not found with the above details", preferredStyle: .alert)
        let done = UIAlertAction(title: "OK", style: .default) { _ in
            self.searchField?.text = ""
            self.searchField?.placeholder = "Please enter valid employ details"
            self.isFiltered = false
            self.employeeTableView?.reloadData()
        }
        
        let emptySearchAlert = UIAlertController(title: "Empty Search!", message: "No employee details entered. Please enter any valid employ details", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Done", style: .default) { _ in
            self.searchField?.text = ""
            self.searchField?.placeholder = "Please enter employee detials"
            self.isFiltered = false
            self.employeeTableView?.reloadData()
        }
        
        emptySearchAlert.addAction(ok)
        wrongRecordAlert.addAction(done)
        
        if(searchField?.text == ""){
            present(emptySearchAlert, animated: true, completion: nil)
        } else {
            present(wrongRecordAlert, animated: true, completion: nil)
        }
    }
    
    @objc func filterButtonTapped() {
        
        popOverController = UIAlertController(title: "Filter By", message: "Choose below options to filter the results", preferredStyle: .actionSheet)
        popOverController.addAction(UIAlertAction(title: "Male", style: .default, handler: { _ in
            self.filteredArray.removeAll()
            for employ in self.employeesArray {
                if(employ.gender == .male) {
                    self.filteredArray.append(employ)
                }
            }
            self.isFiltered = true
            self.employeeTableView?.reloadData()
        }))
        
        popOverController.addAction(UIAlertAction(title: "Female", style: .default, handler: { _ in
            self.filteredArray.removeAll()
            for employ in self.employeesArray {
                if(employ.gender == .female) {
                    self.filteredArray.append(employ)
                }
            }
            self.isFiltered = true
            self.employeeTableView?.reloadData()
        }))
        
        popOverController.addAction(UIAlertAction(title: "Last Name", style: .default, handler: { _ in
            
            self.filteredArray.removeAll()
            for employ in self.employeesArray {
                for checker in self.employeesArray {
                    if(employ.lastName == checker.lastName && employ.firstName != checker.firstName) {
                        self.filteredArray.append(employ)
                    }
                }
            }
            self.isFiltered = true
            self.employeeTableView?.reloadData()
        }))
        
        popOverController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            self.isFiltered = false
            self.employeeTableView?.reloadData()
        }))
        
        popOverController.modalPresentationStyle = .popover
        
        let popOver = popOverController.popoverPresentationController
        popOver?.permittedArrowDirections = .right
        popOver?.sourceView = self.filterButton
        popOver?.sourceRect = self.filterButton.bounds
        
        present(popOverController, animated: true, completion: nil)
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
            self.updateTable()
            isFiltered = true
            self.employeeTableView?.reloadData()
        }
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {

        isFiltered = false
        searchAlert = false
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
