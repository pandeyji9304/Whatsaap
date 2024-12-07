//
//  SettingsView.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 13/09/24.
//

import SwiftUI

struct SettingsView: View {
  @Environment (\.dismiss) private var dismiss
  @StateObject private var viewModel = SettingsViewModel()
  private var user: User?

  init(user: User?)  {
    self.user = user
   }
     var body: some View {
      ScrollView{
        VStack{
          NavigationLink{
            ProfileView(user: user)
              .navigationBarBackButtonHidden()
          } label: {
            HStack(spacing: 12) {
              CircularProfileImageView(size: .large, user: user)
              VStack(alignment: .leading){
                Text(user?.fullname ?? "")
                  .font(.headline)
                  .fontWeight(.semibold)
                  .foregroundStyle(.black)
                 Text("Hey there! I am using WhatsApp.")
                  .font(.footnote)
                  .foregroundStyle(.gray)


              }
                Spacer()
             }
            .padding(.horizontal)
            .padding(.top)
          }
          Divider()
            .padding(.vertical)
          VStack(spacing: 32) {
            ForEach(SettingsOption.allCases) {option in
              Button {
                if option == .logout  {
                  viewModel.logout()
                }
              } label: {
                HStack(spacing: 24) {
                  Image(systemName: option.imageName)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.gray)
                  VStack(alignment: .leading) {
                    Text(option.title)
                      .font(.headline)
                      .fontWeight(.semibold)
                      .foregroundStyle(.black)
                    if option.subtitle != "" {
                      Text(option.subtitle)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    }
                   }
                  Spacer()
                }
              }
            }
          }
          .padding(.horizontal)
        }
        .toolbar(viewModel.tabbarVisibility, for: .tabBar)
        .toolbar{
          ToolbarItem(placement: .topBarLeading) {
            HStack {
              Button{
                viewModel.tabbarVisibility = .visible
                  dismiss()
              } label: {
                  Image(systemName: "arrow.backward")
              }
              Text("Settings")
            }
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(.white)

            }
          ToolbarItem(placement: .topBarTrailing) {
              Image(systemName: "magnifyingglass")
                  .font(.subheadline)
                  .foregroundStyle(.white)
                  .fontWeight(.semibold)
          }
        }
      }
    }
  }

#Preview {
  SettingsView(user: User.MOCK_USER)
}
