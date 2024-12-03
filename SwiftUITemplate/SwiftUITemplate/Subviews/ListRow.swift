//
//  ListRow.swift
//  SwiftUITemplate
//
//  Created by Gemuele Aludino on 11/27/24.
//

import SwiftUI

struct ListRow: View {
    private var label: String
    private var detail: String
    
    init(label: String, detail: String) {
        self.label = label
        self.detail = detail
    }

    var body: some View {
        HStack {
            Text("\(label)")
            Spacer()
            Text("\(detail)")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    List {
        ListRow(label: "Label", detail: "Detail")
    }
}
