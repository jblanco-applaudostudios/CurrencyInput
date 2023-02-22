//
//  CryptoInputType.swift
//  KeyboardKitTest
//
//  Created by Josseh Blanco on 22/2/23.
//

import Foundation

struct CryptoInputType: InputType {
    
    // MARK: - Protocol Implementation
    var minimumDivisorQuantity: Decimal {
        100
    }
    
    var maximumDivisorQuantity: Decimal {
        100000000
    }
    
    func format(_ amount: Decimal, divisorQuantity: Decimal) -> String {
        let decimalAmount = amount/divisorQuantity
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 8
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle  = .currency
        numberFormatter.currencySymbol = "BTC"
        let nsNumber = NSDecimalNumber(decimal: decimalAmount)
        return numberFormatter.string(from: nsNumber) ?? ""
    }
    
    func toDecimal(_ text: String) -> Decimal? {
        var value = text
        value.removeAll(where: {".".contains($0)})
        value.removeAll(where: {",".contains($0)})
        value.removeAll(where: {"BTC".contains($0)})
        return Decimal(string: value)
    }
}

extension InputType where Self == CryptoInputType {
    static var crypto: CryptoInputType {
        .init()
    }
}
