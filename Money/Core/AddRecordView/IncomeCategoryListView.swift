//
//  IncomeCategoryListView.swift
//  Money
//
//  Created by Iacob Zanoci on 20/12/2024.
//

import SwiftUI

struct IncomeCategoryListView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MoneyViewModel
    @State private var searchText: String = ""
    
    var filteredCategories: [IncomeCategory] {
        if searchText.isEmpty {
            return viewModel.incomeCategories
        } else {
            return viewModel.incomeCategories.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Custom Navigation Bar
                CustomNavBar(
                    title: "Categories",
                    icon: "chevron.left",
                    iconColor: Color.theme.green,
                    titleColor: Color.theme.accent
                ) {
                    dismiss()
                }
                
                VStack {
                    HStack {
                        TextField("Search", text: $searchText)
                            .padding(8)
                            .padding(.horizontal, 24) // Space for magnifying glass
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.theme.searchBarBackground)
                            )
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                    
                                    Spacer()
                                    
                                    if !searchText.isEmpty {
                                        Button(action: {
                                            searchText = ""
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 8)
                                        }
                                    }
                                }
                            )
                            .font(.system(size: 14))
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                VStack(spacing: 24) {
                    
                    // Recently Used Section
                    VStack(spacing: 16) {
                        HStack {
                            Text("RECENTLY USED")
                                .font(.system(size: 14, weight: .semibold, design: .default))
                                .foregroundStyle(Color.theme.accent)
                            Spacer()
                        }
                        
                        HStack(spacing: 10) {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(Color.theme.green)
                                .overlay(
                                    Image(systemName: "square.grid.2x2.fill")
                                        .font(.system(size: 24))
                                        .foregroundStyle(Color.theme.white)
                                )
                            
                            Text("Recently selected categories will be shown here")
                                .font(.system(size: 12, weight: .regular, design: .default))
                                .foregroundStyle(Color.theme.accent).opacity(0.75)
                            
                            Spacer()
                        }
                    }
                    
                    // All Categories Section
                    VStack {
                        HStack {
                            Text("ALL CATEGORIES")
                                .font(.system(size: 14, weight: .semibold, design: .default))
                                .foregroundStyle(Color.theme.accent)
                            Spacer()
                        }
                        
                        ScrollView {
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(filteredCategories.indices, id: \.self) { index in
                                    let category = filteredCategories[index]
                                    
                                    Button(action: {
                                        viewModel.selectIncomeCategory(category)
                                        dismiss()
                                    }) {
                                        HStack(spacing: 7) {
                                            
                                            ZStack {
                                                Circle()
                                                    .foregroundStyle(Color.theme.green)
                                                    .frame(width: 30, height: 30)
                                                    .overlay(
                                                        Image(systemName: category.icon)
                                                            .font(.system(size: 14.5))
                                                            .foregroundStyle(Color.theme.white)
                                                    )
                                            }
                                            
                                            Text(category.name)
                                                .font(.system(size: 12, weight: .medium, design: .default))
                                                .foregroundColor(Color.theme.accent)
                                            
                                            Spacer()
                                        }
                                        .padding(.vertical, 12)
                                    }
                                    
                                    // Add a Divider after each category, except the last one
                                    if index < filteredCategories.count - 1 {
                                        Divider()
                                            .background(Color.theme.accent.opacity(0.2))
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    IncomeCategoryListView(viewModel: MoneyViewModel())
}
