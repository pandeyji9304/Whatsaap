//
//  NewMessageView.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 06/09/24.
//

import SwiftUI

struct NewMessageView: View {
  @Environment (\.dismiss) private var dismiss
  @StateObject private var viewModel = NewMessageViewModel()
  @Binding var selectedUser: User?
    var body: some View {
      NavigationStack{
        ScrollView{
          VStack(alignment: .leading,spacing: 24){
            ContectView(imageName: "person.2.circle.fill", title: "New group")
            ContectView(imageName: "person.circle.fill", title: "New contact")
            ContectView(imageName: "shared.with.you.circle.fill", title: "New community")
          }
          .padding(.top)
             Text("Contacts on WhatsApp")
            .foregroundStyle(Color(.darkGray))
            .padding(.vertical)
            .frame(maxWidth: .infinity,alignment: .leading)
            .font(.footnote)
            .fontWeight(.semibold)
          ForEach(viewModel.users){user in
            HStack{
              CircularProfileImageView(size: .small, user: user)
              VStack(alignment: .leading){
                Text(user .fullname)
                  .font(.subheadline)
                  .fontWeight(.semibold)
                Text("Hi there! i am using WhatsApp")
                  .font(.footnote)
                  .foregroundStyle(.gray)

              }
              Spacer()
            }
            .padding(.bottom,20)
            .onTapGesture {
              selectedUser = user
              dismiss()
            }
          }
        }
        .padding(.horizontal)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            HStack(spacing: 16){
              Button(action: {
                    dismiss()
              }, label: {
                Image(systemName: "arrow.backward")
              })
              VStack(alignment: .leading){
                Text("Select contact")
                  .font(.subheadline)
                  .fontWeight(.semibold)
                Text("2 contacts")
                  .font(.caption2)

              }
            }
            .foregroundStyle(.white)
          }
          ToolbarItem(placement: .topBarTrailing){
            HStack(spacing: 24) {
              Image(systemName: "magnifyingglass")
              Image(systemName: "ellipsis")
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
          }
        }
      }
    }
}

#Preview {
  NewMessageView(selectedUser: .constant(User.MOCK_USER))
}

