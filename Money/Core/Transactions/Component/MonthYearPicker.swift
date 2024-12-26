//
//  MonthYearPicker.swift
//  Money
//
//  Created by Iacob Zanoci on 26/12/2024.
//

import SwiftUI

struct MonthYearPicker: View {
    @Binding var selectedMonth: String
    @Binding var selectedYear: String
    @Environment(\.dismiss) var dismiss
    
    private let months = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ]
    private let years = ["2023", "2024", "2025"]
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Select Month", selection: $selectedMonth) {
                    ForEach(months, id: \.self) { month in
                        Text(month)
                    }
                }
                
                Picker("Select Year", selection: $selectedYear) {
                    ForEach(years, id: \.self) { year in
                        Text(year)
                    }
                }
            }
            .navigationTitle("Select Month & Year")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
