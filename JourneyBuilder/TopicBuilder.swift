//
//  TopicBuilder.swift
//  JourneyBuilder
//
//  Created by Jakob Paul Körber on 13.12.22.
//

import Foundation
import SwiftUI

struct TopicAnchors<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key:Value] { [:] }
    static func reduce(value: inout [Key:Value], nextValue: () -> [Key:Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct TopicLine: Shape {
    var from: CGPoint
    var to: CGPoint

    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.from)
            p.addLine(to: self.to)
        }
    }
}

struct TopicViewBuilder<V: View>: View {
    let topicBranch: TopicBranch
    let node: (Course) -> V
    
    typealias anchors = JourneyAnchors<UUID, Anchor<CGPoint>>
    
    var body: some View {
        Text("Topic")
    }
}
