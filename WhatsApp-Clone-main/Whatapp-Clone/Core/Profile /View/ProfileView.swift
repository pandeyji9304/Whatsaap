//
//  ProfileView.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 10/09/24.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
  @Environment(\.dismiss) private var dismiss
  @StateObject private var viewModel = ProfileViewModel()
  private var user: User?

  init(user: User?) {
    self.user = user
  }

    var body: some View {
      VStack{
        Button(action: {
          viewModel.showPhotoPicker.toggle()
        }, label: {
          ZStack(alignment: .bottomTrailing){
            ZStack{
              CircularProfileImageView(size: .xxlarge, user: user)
              if let profileImage = viewModel.profileImage {
                profileImage
                  .resizable()
                  .frame(width: 120,height: 120)
                  .scaledToFill()
                  .clipShape(Circle())
              }
            }
            Circle()
              .frame(width: 40,height: 40)
              .foregroundStyle(Color(.darkGray))
              .overlay{
                Image(systemName: "camera.fill")
                  .resizable()
                  .frame(width: 16,height: 16)
                  .foregroundStyle(.white)
              }

          }
          .padding(.vertical)
        })

        VStack(spacing: 32){
          OptionView(imageName: "person.fill", title: "Name", subtitle: user?.fullname ?? "",isEditable: true, secondSubtitle: "This is not your user or pin.This name will be visible on WhatsApp contacts")
          OptionView(imageName: "exclamationmark.circle", title: "About", subtitle: "Hey there! I am using WhatsApp.", isEditable: true, secondSubtitle: "")
          OptionView(imageName: "phone.fill", title: "Phone", subtitle: user?.phoneNumber ?? "")
        }
        .padding(.leading)
        .padding(.trailing,16)
        Spacer()

      }
      .toolbar(viewModel.tabbarVisibality, for:.tabBar)
      .toolbar {
        ToolbarItem(placement: .topBarLeading){
          HStack{
            Button {
              viewModel.tabbarVisibality = .visible
              dismiss()
            } label: {
              Image(systemName: "arrow.backward")
            }

            Text("Profile")
          }
          .font(.title3)
          .foregroundStyle(.white)
          .fontWeight(.semibold)
        }
      }
      .photosPicker(isPresented:  $viewModel.showPhotoPicker, selection: $viewModel.selectedImage)
    }
}

#Preview {
  ProfileView(user: User.MOCK_USER)
}

struct OptionView: View {
  private var imageName: String
  private var title: String
  private var subtitle: String
  private var isEditable: Bool = false
  private var secondSubtitle: String = ""
  init(imageName: String, title: String, subtitle: String) {
    self.imageName = imageName
    self.title = title
    self.subtitle = subtitle

  }
  init(imageName: String, title: String, subtitle: String, isEditable: Bool,secondSubtitle: String) {
    self.imageName = imageName
    self.title = title
    self.subtitle = subtitle
    self.isEditable = isEditable
    self.secondSubtitle = secondSubtitle
  }
  var body: some View {
    HStack(alignment: secondSubtitle != "" ? .top: .center, spacing: 24){
      Image(systemName: imageName)
        .resizable()
        .frame(width: 16,height: 16)
        .scaledToFill()
        .foregroundStyle(.gray)
        .padding(.top, secondSubtitle != "" ? 12 : 0)
      VStack(alignment: .leading){
        Text(title)
          .font(.headline)
          .foregroundStyle(.gray)
        Text(subtitle)
          .font(.footnote)
        if secondSubtitle != "" {
          Text(secondSubtitle)
            .font(.caption)
            .foregroundStyle(.gray)
            .padding(.top,1)
        }
      }
      Spacer()
      if isEditable{
        Image(systemName: "pencil")
          .resizable()
          .frame(width: 16,height: 16)
          .scaledToFill()
          .foregroundStyle(.gray)
      }
    }
  }
}
