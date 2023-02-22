//
//  Extensions.swift
//  KeyboardKitTest
//
//  Created by Josseh Blanco on 22/2/23.
//

import Combine
import Foundation
import SwiftUI

extension View {
    
    /// Convenience function that provides currency formatting
    func currencyInput(
        text: Binding<String>,
        currencyType: InputType,
        inputActions: PassthroughSubject<CurrenctyInputAction, Never> = .init()
    ) -> some View {
        CurrencyInputWrapper(text: text, inputType: currencyType, inputActions: inputActions) {
            self
        }
    }
}
