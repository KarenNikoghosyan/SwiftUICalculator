//
//  BackgroundColorStyle.swift
//  SwiftUICalculator
//
//  Created by Karen Nikoghosyan on 08/09/2022.
//

import Foundation
import SwiftUI

struct BackgroundColorStyle: ViewModifier {
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    
    func body(content: Content) -> some View {
        if colorScheme == .light {
            return content
                .background(Color.init(UIColor(red: 42 / 255, green: 42 / 255, blue: 42 / 255, alpha: 1)).ignoresSafeArea())
        } else {
            return content
                .background(Color.white.ignoresSafeArea())
        }
    }
}
