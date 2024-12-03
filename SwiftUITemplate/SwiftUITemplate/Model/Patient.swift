//
//  Patient.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import Foundation

struct Patient: Codable, Hashable, Identifiable {
    let firstName: String
    let lastName: String

    let id: Int
    
    init(firstName: String,
         lastName: String,
         id: Int = Int.random(in: 0 ... 1000)) {
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
    }
}
