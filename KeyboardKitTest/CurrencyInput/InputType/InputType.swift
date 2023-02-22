//
//  InputType.swift
//  KeyboardKitTest
//
//  Created by Josseh Blanco on 22/2/23.
//

import Foundation

protocol InputType {
    // MARK: - Variable Declarations
    /// This determines the maximum amount of places the decimal point can be right shifted
    var minimumDivisorQuantity: Decimal { get }
    
    /// This determines the maximum amount of places the decimal point can be left shifted
    var maximumDivisorQuantity: Decimal { get }
    
    // MARK: - Public Methods
    /// This function returns a formatted currency string
    func format(_ amount: Decimal, divisorQuantity: Decimal) -> String
    
    /// This function converts a string to a decimal, removing any unnecessary character
    func toDecimal(_ text: String) -> Decimal?
}
