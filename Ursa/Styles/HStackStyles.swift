//
//  HStackStyles.swift
//  Ursa
//
//  Created by aydar.media on 22.07.2023.
//

import Foundation
import SwiftUI

fileprivate struct HStackStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
//            .background(Color.blue)
    }
}

extension View {
    func hstackStyle() -> some View {
        self.modifier(HStackStyle())
    }
}
