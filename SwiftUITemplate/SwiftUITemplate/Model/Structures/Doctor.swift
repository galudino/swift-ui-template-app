//
//  Doctor.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import Foundation

struct Doctor: Codable, Hashable {
    let firstName: String
    let lastName: String
    
    let department: String
}

extension Doctor: Identifiable {
    class DoctorRef {
        let doctor: Doctor
        init(doctor: Doctor) { self.doctor = doctor }
    }
    
    var id: ObjectIdentifier {
        ObjectIdentifier(DoctorRef(doctor: self))
    }
}
