//
//  ContentView.swift
//  GuessWho
//
//  Created by Oleksandr Latyntsev on 14/01/2025.
//

import SwiftUI

struct ContentView: View {
    let dal = DI.dataAccessLayer
    @State var users = [User]()
    @State var error: Error?

    var body: some View {
        if let error {
            Text("Error: \(error.localizedDescription)")
            Button("Retry") {
                Task {
                    await fetchData()
                }
            }
        }
        List(users, id: \.id) { user in
            userRow(user: user)
        }
        .task {
            await fetchData()
        }
    }
    
    private func userRow(user: User) -> some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: user.avatar)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .background(Color.teal)
            .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(user.name)
                Text(user.email)
            }
        }
    }
    
    func fetchData() async {
        error = nil
        do {
            users = try await dal.fetchUsers()
        } catch {
            self.error = error
        }
    }
}

#Preview {
    ContentView()
}
