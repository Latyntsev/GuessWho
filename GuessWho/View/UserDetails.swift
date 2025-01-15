//
//  UserDetails.swift
//  GuessWho
//
//  Created by Oleksandr Latyntsev on 15/01/2025.
//

import SwiftUI

struct UserDetails: View {
    let user: User
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user.avatar)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            .background(Color.teal)
            .clipShape(Circle())
            
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person")
                        .frame(width: 20)
                    Text(user.role)
                }
                HStack {
                    Image(systemName: "envelope")
                        .frame(width: 20)
                    Text(user.email)
                }
                HStack {
                    Image(systemName: "lock")
                        .frame(width: 20)
                    Text(user.password)
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            Spacer()
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        UserDetails(user: .mock())
    }
}
