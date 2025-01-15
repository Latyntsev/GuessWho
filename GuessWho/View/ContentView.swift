//
//  ContentView.swift
//  GuessWho
//
//  Created by Oleksandr Latyntsev on 14/01/2025.
//

import SwiftUI

struct ContentView: View {
    enum ContantState: Equatable {
        case loading
        case loaded([User])
        case error(Error)
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading):
                return true
            case (.loaded, .loaded):
                return true
            case (.error, .error):
                return true
            default:
                return false
            }
        }
    }
    let dal = DI.dataAccessLayer
    @State var contentState = ContantState.loading

    var body: some View {
        content()
            .animation(.easeInOut, value: contentState)
            .task {
                await fetchData()
            }
    }
    
    @ViewBuilder
    private func content() -> some View {
        switch contentState {
        case .loading:
            loadingState()
        case .loaded(let users):
            loadedState(users: users)
        case .error(let error):
            errorState(error: error)
        }
    }
    
    private func loadingState() -> some View {
        ProgressView()
    }
    
    private func loadedState(users: [User]) -> some View {
        NavigationStack {
            List(users, id: \.id) { user in
                NavigationLink {
                    UserDetails(user: user)
                } label: {
                    UserRow(user: user)
                }
            }
            .navigationTitle("Users")
        }
    }
    
    private func errorState(error: Error) -> some View {
        VStack {
            Text("Error: \(error.localizedDescription)")
            Button("Retry") {
                Task {
                    await fetchData()
                }
            }
        }
    }
    
    func fetchData() async {
        contentState = .loading
        do {
            contentState = .loaded(try await dal.fetchUsers())
        } catch {
            contentState = .error(error)
        }
    }
}

#Preview {
    ContentView()
}
