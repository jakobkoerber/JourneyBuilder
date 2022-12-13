//
//  ContentView.swift
//  JourneyBuilder
//
//  Created by Jakob Paul Körber on 13.12.22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: Model
    
    @State var selectedTopic: Topic?
    
    @State var selectedTag: String?
    
    var body: some View {
        NavigationStack {
            ScrollView([.vertical, .horizontal], showsIndicators: false) {
                // TODO: implement with tags
                
                if let selectedTopic {
                    if let topic = model.journey[selectedTopic] {
                        TopicViewBuilder(topicBranch: topic) { course in
                            circle(course: course, bool: false)
                        }
                    }
                } else {
                    ZStack {}
                    .task {
                        print(model.topicTree.children)
                    }
                    JourneyViewBuilder(topic: model.topicTree) { topic, root in
                        journeyCircle(topic: topic, root: root)
                    }
                }
            }
            .navigationTitle("My Journey")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                /// temporary
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        selectedTopic = nil
                    } label: {
                        Text("View All")
                    }
                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    topicMenu
//                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    tagMenu
                }
            }
            .onAppear {
//                print(model.topicTree.children)
            }
        }
    }
    
    var topicMenu: some View {
        // TODO: @Jakob - implement with all topics
        Menu("Topic") {
            Button(
                action: { selectedTopic = nil },
                label: {
                    if selectedTopic == nil {
                        Label("View All", systemImage: "checkmark")
                    } else {
                        Text("View All")
                    }
                }
            )
        }
    }
    
    var tagMenu: some View {
        // TODO: implement with tags
        Menu("Tags") {
            Button(
                action: { selectedTag = nil },
                label: {
                    if selectedTag == nil {
                        Label("View All", systemImage: "checkmark")
                    } else {
                        Text("View All")
                    }
                }
            )
        }
    }
    
    @ViewBuilder
    func journeyCircle(topic: Topic?, root: Bool) -> some View {
        // TODO: styling
        if let topic {
            Button {
                selectedTopic = topic
            } label: {
                Circle()
                    .stroke(.black, lineWidth: 1)
                    .frame(width: 50, height: 50)
                    .background(.white)
                    .overlay {
                        Text(topic.name)
                    }
            }
        }
    }
    
    @ViewBuilder
    func circle(course: Course?, bool: Bool) -> some View {
        if bool {
            RoundedRectangle(cornerRadius: 40)
                .stroke(.black, lineWidth: 1)
                .frame(width: 350, height: 50)
                .background(.white)
                .overlay {
                    if let course {
                        Text(course.name)
                    }
                }
        } else {
            Circle()
                .stroke(.black, lineWidth: 1)
                .frame(width: 50, height: 50)
                .background(.white)
                .hidden()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MockModel() as Model)
    }
}
