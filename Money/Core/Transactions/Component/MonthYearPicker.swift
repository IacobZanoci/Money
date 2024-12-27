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
                Picker(selection: $selectedMonth, label: Text("Select Month")
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(Color.theme.accent)
                ) {
                    ForEach(months, id: \.self) { month in
                        Text(month)
                    }
                }
                
                Picker(selection: $selectedYear, label: Text("Select Year")
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(Color.theme.accent)
                ) {
                    ForEach(years, id: \.self) { year in
                        Text(year)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.theme.white)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Select Month & Year")
                        .font(.system(size: 17, weight: .semibold, design: .default))
                        .foregroundColor(Color.theme.accent)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .background(Color.theme.white.edgesIgnoringSafeArea(.all))
    }
}
