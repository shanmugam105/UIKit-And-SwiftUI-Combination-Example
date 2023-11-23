//
//  UserNameListContentView.swift
//  UIKit-And-SwiftUI-Combination-Example
//
//  Created by Sparkout on 23/11/23.
//

import SwiftUI

class UserNameListViewModel: ObservableObject {
    @Published var users: [String]
    @Published var updatedUserList: [String] = []
    init(users: [String]) {
        self.users = users
    }
}

struct UserNameListContentView: View {
    @ObservedObject var usersVM: UserNameListViewModel
    
    var body: some View {
        VStack {
            VStack {
                ForEach(usersVM.users, id: \.self) { name in
                    Text("\(name).dev")
                }
            }
            Divider()
            Text("Success")
            Button {
                usersVM.updatedUserList = ["Shan.1", "VK.1", "AK.1", "VP.1"]
            } label: {
                Text("Submit")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
        .padding(12)
        .background(Color.green)
        .onAppear {
            print("SwiftUI Appeared!")
        }
        .onDisappear {
            print("SwiftUI Disppeared!")
        }
    }
}

