//
//  CustomContentUnavailableView.swift
//  ChickenCoopModel
//
//  Created by Furkan İSLAM on 24.06.2025.
//

import SwiftUI

struct CustomContentUnavailableView: View {
    var icon: String
    var title: String
    var description: String
    
    var body: some View {
        ContentUnavailableView {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 96)
            Text(title)
                .font(.title)
        } description: {
            Text(description)
        }
        .foregroundStyle(.tertiary)
    }
}

#Preview {
    CustomContentUnavailableView(
        icon: "bird.circle",
        title: "No Photo",
        description: "Add a photo to get started."
    )
}
