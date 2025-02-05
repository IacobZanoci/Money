//
//  CurrencyData.swift
//  Money
//
//  Created by Iacob Zanoci on 16/01/2025.
//

import Foundation

struct Currency: Identifiable {
    let id = UUID()
    let code: String
    let name: String
}

struct CurrencyData {
    static let currencies: [Currency] = [
        Currency(code: "USD", name: "United States Dollar"),
        Currency(code: "EUR", name: "Euro"),
        Currency(code: "JPY", name: "Japanese yen"),
        Currency(code: "GBP", name: "Sterling"),
        Currency(code: "CNY", name: "Renminbi"),
        Currency(code: "AUD", name: "Australian dollar"),
        Currency(code: "CAD", name: "Canadian dollar"),
        Currency(code: "CHF", name: "Swiss franc"),
        Currency(code: "HKD", name: "Hong Kong dollar"),
        Currency(code: "SGD", name: "Singapore dollar"),
        Currency(code: "SEK", name: "Swedish krona"),
        Currency(code: "KRW", name: "South Korean won"),
        Currency(code: "NOK", name: "Norwegian krone"),
        Currency(code: "NZD", name: "New Zealand dollar"),
        Currency(code: "INR", name: "Indian rupee"),
        Currency(code: "MXN", name: "Mexican peso"),
        Currency(code: "MDL", name: "Moldovan leu"),
        Currency(code: "TWD", name: "New Taiwan dollar"),
        Currency(code: "ZAR", name: "South African rand"),
        Currency(code: "BRL", name: "Brazilian real"),
        Currency(code: "DKK", name: "Danish krone"),
        Currency(code: "PLN", name: "Polish złoty"),
        Currency(code: "THB", name: "Thai baht"),
        Currency(code: "ILS", name: "Israeli new shekel"),
        Currency(code: "IDR", name: "Indonesian rupiah"),
        Currency(code: "CZK", name: "Czech koruna"),
        Currency(code: "AED", name: "UAE dirham"),
        Currency(code: "TRY", name: "Turkish lira"),
        Currency(code: "HUF", name: "Hungarian forint"),
        Currency(code: "CLP", name: "Chilean peso"),
        Currency(code: "SAR", name: "Saudi riyal"),
        Currency(code: "PHP", name: "Philippine peso"),
        Currency(code: "MYR", name: "Malaysian ringgit"),
        Currency(code: "COP", name: "Colombian peso"),
        Currency(code: "RUB", name: "Russian ruble"),
        Currency(code: "RON", name: "Romanian leu"),
        Currency(code: "PEN", name: "Peruvian sol")
    ]
}
