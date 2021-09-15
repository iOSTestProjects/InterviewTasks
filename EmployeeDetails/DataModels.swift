//
//  DataModels.swift
//  EmployeeDetails
//
//  Created by Thejas K on 15/09/21.
//

import Foundation

enum Gender {
    case male , female
}

class Employee {
    let firstName : String
    let lastName : String
    let address : String
    let dob : String
    let gender : Gender
    
    init(_ firstName : String ,_ lastName : String ,_ address : String ,_ dob : String ,_ gender : Gender) {
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.dob = dob
        self.gender = gender
    }
}

struct Employees {
    static var employees : [Employee] = []
}
