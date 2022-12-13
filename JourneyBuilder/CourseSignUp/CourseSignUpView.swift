//
//  CourseSignUpView.swift
//  JourneyBuilder
//
//  Created by Jakob Paul Körber on 13.12.22.
//

import SwiftUI

struct CourseSignUpView: View {
    
    @EnvironmentObject var model: Model
    
    @State var presentSignUpSheet = false
    
    var body: some View {
        NavigationStack {
            Button {
                presentSignUpSheet = true
            } label: {
                Text("Sign Up")
            }.sheet(
                isPresented: $presentSignUpSheet,
                onDismiss: {
                    presentSignUpSheet = false
                },
                content: {
                    SignUpSheet(model)
                }
            )
        }
    }
}

struct SignUpSheet: View {
    
    @EnvironmentObject var model: Model
    
    let course: Course = Course(name: "Java 3", date: Date())
    
    @Environment(\.dismiss) private var dismiss

    @StateObject var viewModel: SignUpSheetViewModel

    init(_ model: Model) {
        _viewModel = StateObject(wrappedValue: SignUpSheetViewModel(model))
    }
    
    @State var topicSelection: Topic?
    
    @State var topicCreationSheet = false
    
    var body: some View {
        NavigationStack {
            Form {
                Button {
                    topicCreationSheet = true
                } label: {
                    Label("Create new Topic", systemImage: "plus")
                }.sheet(
                    isPresented: $topicCreationSheet,
                    onDismiss: {
                        topicCreationSheet = false
                        viewModel.updateStates()
                    },
                    content: {
                        TopicCreatorView(model)
                    }
                )
                NodeOutlineGroup(node: model.topicTree, childKeyPath: \.children, isExpanded: true) { child in
                    Button {
                        if topicSelection == child {
                            topicSelection = nil
                        } else {
                            topicSelection = child
                        }
                    } label: {
                        HStack(alignment: .center, spacing: 10) {
                            Image(systemName: self.topicSelection == child ? "largecircle.fill.circle" : "circle")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            Text(child.name)
                                .font(Font.system(size: 14))
                            Spacer()
                        }
                        .foregroundColor(.black)
                    }
                }
            }
            .onAppear {
                viewModel.updateStates()
            }
            .navigationTitle("Choose a Topic")
        }
    }
    
    @ViewBuilder
    func pickerItem(topic: Topic) -> some View {
        VStack {
            Text(topic.name)
            if let children = topic.children {
                ForEach(children) { child in
                    AnyView(pickerItem(topic: child))
                    //pickerItem(topic: child)
                }
            }
        }
    }
}

struct CourseSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        CourseSignUpView()
            .environmentObject(MockModel() as Model)
    }
}
