//
//  ToastView.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import Foundation
import SwiftUI

struct ToastView: ViewModifier {
    @Binding var showToast: Bool
    var message: ToastMessageModel?
    
    func body(content: Content) -> some View {
        ZStack {
            content
            toastView
        }
    }
    
    private var toastView: some View {
        VStack {
            Spacer()
            if showToast {
                Button {
                    showToast = false
                } label: {
                    MessageView(message: message?.title ?? "")
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 40, trailing: 16))
                }
            }
        }
        .animation(.linear(duration: 0.3), value: showToast)
        .transition(.opacity)
    }
}
