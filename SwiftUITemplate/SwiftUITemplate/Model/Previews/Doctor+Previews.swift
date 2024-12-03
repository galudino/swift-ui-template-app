//
//  Doctor+Previews.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/2/24.
//

extension Doctor {
    static var previews: [Doctor] {
        [
            Doctor(firstName: "Gregory",
                   lastName: "House",
                   department: "Diagnostics"),
            Doctor(firstName: "James",
                   lastName: "Wilson",
                   department: "Oncology"),
            Doctor(firstName: "Eric",
                   lastName: "Foreman",
                   department: "Diagnostics"),
            Doctor(firstName: "Robert",
                   lastName: "Chase",
                   department: "Diagnostics"),
            Doctor(firstName: "Allison",
                   lastName: "Cameron",
                   department: "Emergency Room"),
            Doctor(firstName: "Andre", lastName: "Youssouf", department: "Addiction"),
        ]
    }
}
