//
//  TopicCreationView.swift
//  JourneyBuilder
//
//  Created by Jakob Paul Körber on 13.12.22.
//

import SwiftUI

struct TopicCreatorView: View {
    
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var model: Model

    @StateObject var viewModel: TopicCreatorViewModel
    
    @State var savingNotPossible: Bool = true

    init(_ model: Model) {
        _viewModel = StateObject(wrappedValue: TopicCreatorViewModel(model))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Topic's Name", text: $viewModel.name)
                        .onReceive(viewModel.$name) { _ in
                            if !viewModel.name.isEmpty && viewModel.parent != nil && viewModel.name.count > 1 {
                                savingNotPossible = false
                            } else {
                                savingNotPossible = true
                            }
                        }
                }
                Section("Color") {
                    ColorPicker("Pick a Color", selection: $viewModel.color)
                }
                Section("Parent") {
                    List {
                        NodeOutlineGroup(node: model.topicTree, childKeyPath: \.children, isExpanded: true) { child in
                            RadioButtonView(selection: $viewModel.parent, topic: child)
                                .onReceive(viewModel.$parent) { _ in
                                    if !viewModel.name.isEmpty && viewModel.parent != nil && viewModel.name.count > 1 {
                                        savingNotPossible = false
                                    } else {
                                        savingNotPossible = true
                                    }
                                }
                        }
                    }
                }
                if viewModel.parent != nil {
                    Section("Child") {
                        List {
                            ForEach(viewModel.parent?.children ?? []) { child in
                                RadioButtonView(selection: $viewModel.child, topic: child)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Create new Topic")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.saveNewTopic()
                        dismiss()
                    } label: {
                        Text("Save")
                    }.disabled(savingNotPossible)
                }
            }
        }
    }
}

struct TopicCreatorView_Previews: PreviewProvider {
    static var previews: some View {
        TopicCreatorView(MockModel() as Model)
            .environmentObject(MockModel() as Model)
    }
}
