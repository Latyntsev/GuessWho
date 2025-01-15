//
//  UserRow.swift
//  GuessWho
//
//  Created by Oleksandr Latyntsev on 15/01/2025.
//

import SwiftUI

struct UserRow: View {
    let user: User
    var body: some View {
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
}

#Preview {
    List(0...2, id: \.self) { _ in
        UserRow(user: .mock())
    }
}
