//
//  CurrencyInputWrapperViewModel.swift
//  KeyboardKitTest
//
//  Created by Josseh Blanco on 22/2/23.
//

import Combine
import Foundation

class CurrencyInputWrapperViewModel: ObservableObject {
    
    // MARK: - Variable Declarations
    @Published var decimalValue: Decimal = 0.0
    @Published var currentDivisorQuantity: Decimal = 100
    var inputActions: PassthroughSubject<CurrenctyInputAction, Never> = .init()
    var inputType: InputType = .dollar
    private var didUpdateFormat = false
    
    // MARK: - Computed Properties
    var disableShiftRight: Bool {
        currentDivisorQuantity == inputType.minimumDivisorQuantity
    }
    var disableShiftLeft: Bool {
        currentDivisorQuantity == inputType.maximumDivisorQuantity
    }
    
    // MARK: - Initializer
    init(
        inputType: InputType,
        inputActions: PassthroughSubject<CurrenctyInputAction, Never>
    ) {
        self.inputType = inputType
        self.currentDivisorQuantity = inputType.minimumDivisorQuantity
        self.inputActions = inputActions
    }
    
    // MARK: - Public Methods
    /// Updates the current decimal value based on the current text
    func updateDecimalValue(from text: String) {
        guard let value = inputType.toDecimal(text), !didUpdateFormat else {
            didUpdateFormat = false
            return
        }
        if decimalValue == .zero {
            currentDivisorQuantity = inputType.minimumDivisorQuantity
        }
        decimalValue = value
    }
    
    /// Returns a formatted string based on the inputType's configuration
    func formatText() -> String {
        didUpdateFormat = true
        return inputType.format(decimalValue, divisorQuantity: currentDivisorQuantity)
    }
    
    /// Shifts the decimal point to the right
    func shiftDecimalSeparatorRight() {
        let newDivisorQuantity = currentDivisorQuantity/10
        guard newDivisorQuantity >= inputType.minimumDivisorQuantity else { return }
        currentDivisorQuantity = newDivisorQuantity
    }
    
    /// Shifts the decimal point to the left
    func shiftDecimalSeparatorLeft() {
        let newDivisorQuantity = currentDivisorQuantity*10
        guard newDivisorQuantity <= inputType.maximumDivisorQuantity else { return }
        currentDivisorQuantity = newDivisorQuantity
    }
}
