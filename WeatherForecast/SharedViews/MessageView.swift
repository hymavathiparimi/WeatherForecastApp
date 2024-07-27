//
//  MessageView.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import SwiftUI

struct MessageView: View {
    var message: String = ""
    var textColor: Color = .white
    var borderColor: Color = .red
    var backgroundColor: Color = .clear

    var body: some View {
        Text(message)
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(textColor)
            .font(.system(size: 16))
            .background(backgroundColor)
            .clipShape(
                RoundedRectangle(cornerRadius: 4)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(borderColor, lineWidth: 1)
            )
    }
}

#Preview {
    MessageView()
}
