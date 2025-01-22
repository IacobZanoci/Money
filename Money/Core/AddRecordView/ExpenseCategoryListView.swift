//
//  ExpenseCategoryListView.swift
//  Money
//
//  Created by Iacob Zanoci on 13/12/2024.
//

import SwiftUI

struct ExpenseCategoryListView: View {
    @ObservedObject var viewModel: MoneyViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var searchText: String = ""
    @State private var expenseCategories: [ExpenseCategory] = ExpenseCategory.expenseCategory
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 10) {
                CustomNavBar(
                    title: "Categories",
                    icon: "arrow.left",
                    iconColor: Color.theme.red,
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
                            .foregroundColor(Color.theme.accent)
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
                                ForEach(CategoryFilter.filterExpenseCategories(expenseCategories, searchText: searchText).indices, id: \.self) { index in
                                    let category = CategoryFilter.filterExpenseCategories(expenseCategories, searchText: searchText)[index]
                                    
                                    Button(action: {
                                        viewModel.selectExpenseCategory(category)
                                        dismiss()
                                    }) {
                                        HStack(spacing: 7) {
                                            
                                            ZStack {
                                                Circle()
                                                    .foregroundStyle(Color.theme.red)
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
                                    
                                    if index < CategoryFilter.filterExpenseCategories(expenseCategories, searchText: searchText).count - 1 {
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
    ExpenseCategoryListView(viewModel: MoneyViewModel())
}
