//
//  DollarInputType.swift
//  KeyboardKitTest
//
//  Created by Josseh Blanco on 22/2/23.
//

import Foundation

struct DollarInputType: InputType {
    
    // MARK: - Protocol Implementation
    var minimumDivisorQuantity: Decimal {
        100
    }
    
    var maximumDivisorQuantity: Decimal {
        100
    }
    
    func format(_ amount: Decimal, divisorQuantity: Decimal) -> String {
        let decimalAmount = amount/100
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle  = .currency
        numberFormatter.currencySymbol = "$"
        let nsNumber = NSDecimalNumber(decimal: decimalAmount)
        return numberFormatter.string(from: nsNumber) ?? ""
    }
    
    func toDecimal(_ text: String) -> Decimal? {
        var value = text
        value.removeAll(where: {"$".contains($0)})
        value.removeAll(where: {".".contains($0)})
        value.removeAll(where: {",".contains($0)})
        return Decimal(string: value)
    }
}

extension InputType where Self == DollarInputType {
    static var dollar: DollarInputType {
        .init()
    }
}

/// Types of currency inputs
enum CurrencyInputType {
    case dollar
    case crypto
    
    // MARK: - Variable Declarations
    /// This determines the maximum amount of places the decimal point can be right shifted
    var minimumDivisorQuantity: Decimal {
        switch self {
        case .dollar:
            return 100
        case .crypto:
            return 100
        }
    }
    
    /// This determines the maximum amount of places the decimal point can be left shifted
    var maximumDivisorQuantity: Decimal {
        switch self {
        case .dollar:
            return 100
        case .crypto:
            return 100000000
        }
    }
    
    // MARK: - Public Methods
    /// This function returns a formatted currency string
    func format(_ amount: Decimal, divisorQuantity: Decimal = 100) -> String {
        switch self {
        case .dollar:
            return formatDollar(amount: amount)
        case .crypto:
            return formatCrypto(amount: amount, divisorQuantity: divisorQuantity)
        }
    }
    
    /// This function converts a string to a decimal, removing any unnecessary character
    func toDecimal(_ text: String) -> Decimal? {
        var value = text
        value.removeAll(where: {"$".contains($0)})
        value.removeAll(where: {".".contains($0)})
        value.removeAll(where: {",".contains($0)})
        value.removeAll(where: {"BTC".contains($0)})
        return Decimal(string: value)
    }
    
    // MARK: - Private Methods
    private func formatDollar(amount: Decimal) -> String {
        let decimalAmount = amount/100
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle  = .currency
        numberFormatter.currencySymbol = "$"
        let nsNumber = NSDecimalNumber(decimal: decimalAmount)
        return numberFormatter.string(from: nsNumber) ?? ""
    }
    
    private func formatCrypto(amount: Decimal, divisorQuantity: Decimal = 100) -> String {
        let decimalAmount = amount/divisorQuantity
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 8
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle  = .currency
        numberFormatter.currencySymbol = "BTC"
        let nsNumber = NSDecimalNumber(decimal: decimalAmount)
        return numberFormatter.string(from: nsNumber) ?? ""
    }
}
