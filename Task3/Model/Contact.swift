//
//  Contact.swift
//  Task3
//
//  Created by Tester on 10/22/18.
//  Copyright © 2018 aaa. All rights reserved.
//

import Foundation

struct Contact: Decodable {
    let _id: String
    let firstName: String
    let lastName: String
    let phone: String
    let email: String
    let notes: String?
    let images: [String]?
}
