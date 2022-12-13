//
//  Model.swift
//  JourneyBuilder
//
//  Created by Jakob Paul Körber on 13.12.22.
//

import Foundation
import SwiftUI
import OrderedCollections

class Model: ObservableObject {
    @Published var journey: OrderedDictionary<Topic, TopicBranch>
    @Published var topicTree: Topic
    
    init(journey: OrderedDictionary<Topic, TopicBranch>, topicTree: Topic) {
        self.journey = journey
        self.topicTree = topicTree
    }
    
    func saveNewTopic(topic: Topic, parent: Topic?, child: Topic?) {
        if let parent {
            if parent.children != nil {
                parent.children?.append(topic)
            } else {
                parent.children = [topic]
            }
            if let child {
                if let index = parent.children?.firstIndex(of: child) {
                    parent.children?.remove(at: index)
                    if topic.children != nil {
                        topic.children?.append(child)
                    } else {
                        topic.children = [child]
                    }
                }
            }
        }
    }
}

class MockModel: Model {
    public convenience init() {
        let topicTree = Topic(name: "Max Mustermann", children: [Topic(name: "GC", children: [Topic(name: "Advanced Consulting", children: nil), Topic(name: "Advanced Consulting", children: [Topic(name: "Java", children: nil), Topic(name: "Java", children: nil)])]), Topic(name: "Object-Oriented", children: [Topic(name: "Java", children: [Topic(name: "Java", children: nil)])])])
        self.init(journey: [:], topicTree: topicTree)
    }
}

class Topic: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var color: Color?
    var children: [Topic]? = nil
    
    init(id: UUID = UUID(), name: String, color: Color? = nil, children: [Topic]? = nil) {
        self.id = id
        self.name = name
        self.color = color
        self.children = children
    }
    
    static func == (lhs: Topic, rhs: Topic) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(ObjectIdentifier(self))
    }
}

class TopicBranch: Hashable, Identifiable {
    var topicBranchID = UUID()
    var courses: OrderedSet<Course>
    
    init(topicBranchID: UUID = UUID(), courses: OrderedSet<Course>) {
        self.topicBranchID = topicBranchID
        self.courses = courses
    }
    
    static func == (lhs: TopicBranch, rhs: TopicBranch) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(ObjectIdentifier(self))
    }
}

struct Course: Hashable {
    var name: String
    var date: Date
}
