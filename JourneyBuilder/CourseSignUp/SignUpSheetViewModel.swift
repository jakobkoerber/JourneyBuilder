//
//  CourseSignUpViewModel.swift
//  JourneyBuilder
//
//  Created by Jakob Paul Körber on 13.12.22.
//

import Foundation
import SwiftUI
import Combine

class SignUpSheetViewModel: ObservableObject {
    
    @Published var currentTree: Topic
    
    private weak var model: Model?

    private var cancellables: [AnyCancellable] = []

    init(_ model: Model) {
        self.model = model
        self.currentTree = model.topicTree
        self.updateStates()
    }
    
    func updateStates() {
        self.model?.$topicTree.assign(to: \.currentTree, on: self).store(in: &self.cancellables)
    }
}
