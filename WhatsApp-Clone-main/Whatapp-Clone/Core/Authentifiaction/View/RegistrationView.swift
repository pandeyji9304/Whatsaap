//
//  RegistrationView.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 13/09/24.
//

import SwiftUI

struct RegistrationView: View {
  @StateObject private var viewModel = RegistrationViewModel()
    var body: some View {
      VStack {
            Spacer()
            LogoImageView()
        FloatingField(title: "Email", placeholder: "", text: $viewModel.email)
        FloatingField(title: "Full name", placeholder: "", text: $viewModel.fullname)
        FloatingField(title: "Phone number", placeholder: "", text: $viewModel.phonenumber)
        FloatingField(title: "Password", placeholder: "", text: $viewModel.password)
        Button{
          Task{ try await viewModel.createUser() }
        } label: {
          Text("Sign Up")
            .authentificationButtonModifier()

        }
          .padding(.vertical)
           Spacer()
           Divider()
        NavigationLink{
                LoginView()
        } label: {
          HStack(spacing: 3) {
                Text("Already have an account?")
                 Text("Sign In")
              .fontWeight(.semibold)
             }
               .font(.footnote)
               .foregroundStyle(.gray)

           }
        .padding(.vertical)
        }
     }
  }

#Preview {
    RegistrationView()
}
