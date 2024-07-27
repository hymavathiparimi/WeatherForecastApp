//
//  View+Extensions.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation
import SwiftUI

extension View {
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func placeholder(_ text: String, when shouldShow: Bool, alignment: Alignment = .leading) -> some View {
        placeholder(when: shouldShow, alignment: alignment) {
            Text(text)
                .foregroundColor(Color(.secondaryLabel))
        }
    }
    
    func toast(message: ToastMessageModel?, showToast: Binding<Bool>) -> some View {
        self.modifier(ToastView(showToast: showToast, message: message))
    }
}
