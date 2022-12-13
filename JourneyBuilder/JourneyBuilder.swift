//
//  JourneyBuilder.swift
//  JourneyBuilder
//
//  Created by Jakob Paul Körber on 13.12.22.
//

import Foundation
import OrderedCollections
import SwiftUI

struct JourneyAnchors<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key:Value] { [:] }
    static func reduce(value: inout [Key:Value], nextValue: () -> [Key:Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

struct JourneyLine: Shape {
    var from: CGPoint
    var to: CGPoint

    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.from)
            p.addLine(to: self.to)
        }
    }
}

struct JourneyViewBuilder<V: View>: View {
    let topic: Topic
    let node: (Topic?, Bool) -> V
    
    typealias anchors = JourneyAnchors<Topic.ID, Anchor<CGPoint>>
    
    var body: some View {
        VStack(spacing: 20) {
            node(topic, false)
                .anchorPreference(key: anchors.self, value: .center, transform: {
                    [topic.id: $0]
                })
            HStack(spacing: 20) {
                if let children = topic.children {
                    ForEach(children) { child in
                        JourneyViewBuilder(topic: child, node: node)
                    }
                }
            }
        }
        .backgroundPreferenceValue(anchors.self, { (centers: [UUID: Anchor<CGPoint>]) in
            GeometryReader { proxy in
                if let children = topic.children {
                    ForEach(children) { child in
                        JourneyLine(
                            from: proxy[centers[topic.id]!],
                            to: proxy[centers[child.id]!]
                        )
                        .stroke(style: StrokeStyle(lineWidth: 1))
                        .foregroundColor(.black)
                    }
                }
            }
        })
    }
}
