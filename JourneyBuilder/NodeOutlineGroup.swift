//
//  NodeOutlineGroup.swift
//  JourneyBuilder
//
//  Created by Jakob Paul Körber on 13.12.22.
//

import SwiftUI

/// found on: https://stackoverflow.com/questions/62832809/list-or-outlinegroup-expanded-by-default-in-swiftui
struct NodeOutlineGroup<Node, Content>: View where Node: Hashable, Node: Identifiable, Content: View {
    let node: Node
    let childKeyPath: KeyPath<Node, [Node]?>
    @State var isExpanded: Bool = true
    let content: (Node) -> Content
    
    var body: some View {
        if node[keyPath: childKeyPath] != nil {
            DisclosureGroup(
                isExpanded: $isExpanded,
                content: {
                    if isExpanded {
                        ForEach(node[keyPath: childKeyPath]!) { childNode in
                            NodeOutlineGroup(node: childNode, childKeyPath: childKeyPath, isExpanded: isExpanded, content: content)
                        }
                    }
                },
                label: { content(node) })
        } else {
            content(node)
        }
    }
}
