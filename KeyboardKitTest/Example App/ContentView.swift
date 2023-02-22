//
//  ContentView.swift
//  KeyboardKitTest
//
//  Created by Josseh Blanco on 22/2/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel = .init()
    @FocusState var cryptoFieldIsOpen
    var body: some View {
        VStack {
            TextField("BTC 0.00", text: $viewModel.btcText)
                .textFieldStyle(.roundedBorder)
                .focused($cryptoFieldIsOpen)
                .currencyInput(text: $viewModel.btcText, currencyType: .crypto, inputActions: viewModel.inputAction)
            
            TextField("$0.00", text: $viewModel.dollarText)
                .textFieldStyle(.roundedBorder)
                .currencyInput(text: $viewModel.dollarText, currencyType: .dollar)
        }
        .toolbar {
            toolbarContent
        }
        .padding()
    }
    
    // MARK: - ViewBuilders
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .keyboard) {
            Button {
                viewModel.inputAction.send(.shiftLeft)
            } label: {
                VStack {
                    Text("<")
                }
                
            }
        }
        
        ToolbarItem(placement: .keyboard) {
            Button {
                viewModel.inputAction.send(.shiftRight)
            } label: {
                VStack {
                    Text(">")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
