//
//  MonthYearPicker.swift
//  Money
//
//  Created by Iacob Zanoci on 26/12/2024.
//

import SwiftUI

struct MonthYearPicker: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedMonth: String
    @Binding var selectedYear: String
    
    @ObservedObject var viewModel: MoneyViewModel
    
    private let months = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Picker(selection: $selectedMonth, label: Text("Select Month")
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(Color.theme.accent)
                ) {
                    ForEach(viewModel.availableMonthsForSelectedYear, id: \.self) { month in
                        Text(month)
                    }
                }
                .onChange(of: selectedYear) { _ in
                    if !viewModel.availableMonthsForSelectedYear.contains(selectedMonth) {
                        selectedMonth = viewModel.availableMonthsForSelectedYear.first ?? ""
                    }
                }
                
                Picker(selection: $selectedYear, label: Text("Select Year")
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(Color.theme.accent)
                ) {
                    ForEach(viewModel.distinctYears, id: \.self) { year in
                        Text(year)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.theme.background)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Select Month & Year")
                        .font(.system(size: 17, weight: .semibold, design: .default))
                        .foregroundColor(Color.theme.accent)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color.theme.accent.opacity(0.5), Color.theme.accent.opacity(0.1))
                            .font(.system(size: 22, weight: .semibold))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .background(Color.theme.white.edgesIgnoringSafeArea(.all))
    }
}


struct MonthYearPicker_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var sampleMonth = "January"
        @State var sampleYear = "2024"
        
        let sampleViewModel = MoneyViewModel()
        
        return MonthYearPicker(
            selectedMonth: $sampleMonth,
            selectedYear: $sampleYear,
            viewModel: sampleViewModel
        )
    }
}
