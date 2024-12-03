//
//  ModelData.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 12/2/24.
//

import SwiftUI

// MARK: - ModelData

@Observable
class ModelData {
    var patients: [Patient] = []
    var doctors: [Doctor] = []
    
    init() {
        loadPatients()
        loadDoctors()
    }
    
    var doctorsGroupedByDepartmentSortedByLastNameAscending: [String: [Doctor]] {
        Dictionary(grouping: doctors.sorted(by: { $0.lastName < $1.lastName }),
                   by: { $0.department })
    }
    
    var doctorDepartmentsSortedAscending: [String] {
        doctorsGroupedByDepartmentSortedByLastNameAscending.map(\.key).sorted(by: {
            $0 < $1
        })
    }
    
    private func loadPatients() {
        #if targetEnvironment(simulator)
            patients = Patient.previews
        #else
            // Load real assets
        #endif
    }

    private func loadDoctors() {
        #if targetEnvironment(simulator)
            doctors = Doctor.previews
        #else
            // Load real assets
        #endif
    }

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
