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
    @State private var incomeCategories: [IncomeCategory] = IncomeCategory.incomeCategory
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 10) {
                CustomNavBar(
                    title: "Categories",
                    icon: "arrow.left",
                    iconColor: Color.theme.green,
                    titleColor: Color.theme.accent
                ) {
                    dismiss()
                }
                
                VStack {
                    HStack {
                        TextField("Search", text: $searchText)
                            .padding(8)
                            .padding(.horizontal, 24)
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
                    VStack {
                        HStack {
                            Text("ALL CATEGORIES")
                                .font(.system(size: 14, weight: .semibold, design: .default))
                                .foregroundStyle(Color.theme.accent)
                            Spacer()
                        }
                        
                        ScrollView {
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(CategoryFilter.filterIncomeCategories(incomeCategories, searchText: searchText).indices, id: \.self) { index in
                                    let category = CategoryFilter.filterIncomeCategories(incomeCategories, searchText: searchText)[index]
                                    
                                    Button(action: {
                                        viewModel.selectIncomeCategory(category)
                                        dismiss()
                                    }) {
                                        HStack(spacing: 7) {
                                            
                                            ZStack {
                                                Circle()
                                                    .foregroundStyle(Color.theme.green.opacity(0.1))
                                                    .frame(width: 30, height: 30)
                                                    .overlay(
                                                        Image(systemName: category.icon)
                                                            .font(.system(size: 14.5))
                                                            .foregroundStyle(Color.theme.green)
                                                    )
                                            }
                                            
                                            Text(category.name)
                                                .font(.system(size: 12, weight: .medium, design: .default))
                                                .foregroundColor(Color.theme.accent)
                                            
                                            Spacer()
                                        }
                                        .padding(.vertical, 12)
                                    }
                                    
                                    if index < CategoryFilter.filterIncomeCategories(incomeCategories, searchText: searchText).count - 1 {
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
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    IncomeCategoryListView(viewModel: MoneyViewModel())
}
