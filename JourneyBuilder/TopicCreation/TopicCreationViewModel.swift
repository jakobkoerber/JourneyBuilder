//
//  TopicCreationViewModel.swift
//  JourneyBuilder
//
//  Created by Jakob Paul Körber on 13.12.22.
//

import Foundation
import SwiftUI
import Combine

class TopicCreatorViewModel: ObservableObject {
    
    @Published var name: String = ""
    
    @Published var color: Color = .accentColor
    
    @Published var parent: Topic? = nil
    
    @Published var child: Topic? = nil
    
    private weak var model: Model?

    private var cancellables: [AnyCancellable] = []

    init(_ model: Model) {
        self.model = model
    }
    
    func saveNewTopic() {
        model?.saveNewTopic(topic: Topic(name: self.name, color: self.color, children: nil), parent: self.parent, child: self.child)
    }
}
