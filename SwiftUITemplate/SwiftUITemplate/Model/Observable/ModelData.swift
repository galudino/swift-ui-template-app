//
//  ModelData.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/2/24.
//

import Foundation
import SwiftUI

// MARK: - ModelData

@Observable
class ModelData {
    var patients: [Patient] = []
    var doctors: [Doctor] = []
    
    private var networkService: FakeNetworkService
    
    init(networkService: FakeNetworkService) {
        self.networkService = networkService
    }
}

extension ModelData {
    var doctorsGroupedByDepartmentSortedByLastNameAscending: [String: [Doctor]] {
        Dictionary(grouping: doctors.sorted(by: { $0.lastName < $1.lastName }),
                   by: { $0.department })
    }

    var doctorDepartmentsSortedAscending: [String] {
        doctorsGroupedByDepartmentSortedByLastNameAscending.map(\.key).sorted(by: {
            $0 < $1
        })
    }
}

extension ModelData {
    func addPatient(_ patient: Patient) {
        guard !patients.contains(patient) else {
            return
        }
        patients.append(patient)
    }

    func addDoctor(_ doctor: Doctor) {
        guard !doctors.contains(doctor) else {
            return
        }
        doctors.append(doctor)
    }

    func removePatient(_ patient: Patient) -> Patient? {
        let index = patients.firstIndex(of: patient)!
        return patients.remove(at: index)
    }

    func removeDoctor(_ doctor: Doctor) -> Doctor? {
        let index = doctors.firstIndex(of: doctor)!
        return doctors.remove(at: index)
    }
}
