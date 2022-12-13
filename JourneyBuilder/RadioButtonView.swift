//
//  RadioButtonView.swift
//  JourneyBuilder
//
//  Created by Jakob Paul Körber on 13.12.22.
//

import SwiftUI

struct RadioButtonView: View {
    
    @Binding var selection: Topic?
    
    var topic: Topic
    
    var body: some View {
        Button {
            if selection == topic {
                selection = nil
            } else {
                selection = topic
            }
        } label: {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: self.selection == topic ? "largecircle.fill.circle" : "circle")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                Text(topic.name)
                    .font(Font.system(size: 14))
                Spacer()
            }
            .foregroundColor(.black)
        }
    }
}
