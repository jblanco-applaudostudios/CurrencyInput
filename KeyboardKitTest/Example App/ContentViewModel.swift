//
//  ContentViewModel.swift
//  KeyboardKitTest
//
//  Created by Josseh Blanco on 22/2/23.
//

import Combine
import Foundation

class ContentViewModel: ObservableObject {
    @Published var btcText = ""
    @Published var dollarText = ""
    var inputAction: PassthroughSubject<CurrenctyInputAction, Never> = .init()
}
