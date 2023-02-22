//
//  CurrencyInputWrapper.swift
//  KeyboardKitTest
//
//  Created by Josseh Blanco on 22/2/23.
//

import Combine
import SwiftUI
import Foundation

/// This is a content wrapper that provides currency formatting functionalities
struct CurrencyInputWrapper<Content: View>: View {
    
    // MARK: - Variable Declaration
    @Binding var text: String
    @StateObject var viewModel: CurrencyInputWrapperViewModel
    var content: () -> Content
    
    // MARK: - Initializer
    init(
        text: Binding<String>,
        inputType: InputType,
        inputActions: PassthroughSubject<CurrenctyInputAction, Never> = .init(),
        content: @escaping () -> Content
    ) {
        self._text = text
        self._viewModel = .init(wrappedValue: .init(inputType: inputType, inputActions: inputActions))
        self.content = content
    }
    
    // MARK: - Body
    var body: some View {
        content()
            .keyboardType(.numberPad)
            .onChange(of: $text.wrappedValue) { newValue in
                viewModel.updateDecimalValue(from: newValue)
            }
            .onReceive(viewModel.$decimalValue) { decimalValue in
                text = viewModel.formatText()
            }
            .onReceive(viewModel.inputActions) { action in
                switch action {
                case .shiftLeft:
                    viewModel.shiftDecimalSeparatorLeft()
                    text = viewModel.formatText()
                case .shiftRight:
                    viewModel.shiftDecimalSeparatorRight()
                    text = viewModel.formatText()
                case .done:
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
    }
}
