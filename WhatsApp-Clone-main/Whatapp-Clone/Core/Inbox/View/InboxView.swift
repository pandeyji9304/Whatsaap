//
//  InboxView.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 05/09/24.
//

import SwiftUI

struct InboxView: View {
  @StateObject private var viewModel = InboxViewModel()
  @State private var selectedUser: User?
    var body: some View {
        NavigationStack {
          GeometryReader { proxy in                              ZStack(alignment: .bottomTrailing) {
                  List {
                    ForEach(viewModel.latestMessages) { message in
                      ZStack{
                        NavigationLink {
                          if let selectedUser = message.user {
                            ChatView(selectedUser: selectedUser)
                              .navigationBarBackButtonHidden()
                          }
                        } label: {
                            EmptyView()
                            .opacity(0)
                        }
                        InboxRowView(width: proxy.size.width, message: message)
                      }
                    }
                  }
                  .listStyle(PlainListStyle())

                  Button(action: {
                    viewModel.showNewMessage.toggle()
                    selectedUser = nil 
                  }, label: {
                      RoundedRectangle(cornerRadius: 10)
                          .fill(Color(.darkGray))
                          .frame(width: 50, height: 50)
                          .padding()
                          .overlay {
                              Image(systemName: "plus.bubble.fill")
                                  .foregroundColor(.white)
                          }
                  })
              }
          .fullScreenCover(isPresented: $viewModel.showNewMessage) {
            NewMessageView(selectedUser: $selectedUser)
          }
          .onChange(of: selectedUser, {
            viewModel.showChat = selectedUser != nil
          })
          .navigationDestination(isPresented: $viewModel.showChat, destination: {
            if let selectedUser = selectedUser {
              ChatView(selectedUser: selectedUser)
                .navigationBarBackButtonHidden()
            }
          })
              .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                  HStack(spacing: 22) {
                    Text("WhatApp")
                      .font(.title3)
                      .fontWeight(.semibold)
                      .foregroundStyle(.white)
                      .navigationBarColor(backgroundColor: Color(.darkGray))

                    Spacer()
                  }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                       HStack(spacing: 22) {
                           Image(systemName: "camera")
                               .foregroundColor(.white)

                           Image(systemName: "magnifyingglass")
                               .foregroundColor(.white)
                      NavigationLink{
                        SettingsView(user: viewModel.currentUser)
                          .navigationBarBackButtonHidden()
                       } label:{
                         Image(systemName: "ellipsis")
                      }

                    }
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                }


            }
          }
        }
    }
}

#Preview {
    InboxView()
}

