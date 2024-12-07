//
//  RegistrationViewModel.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 13/09/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {

  @Published var email: String = ""
  @Published var fullname: String = ""
  @Published var phonenumber: String = ""
  @Published var password: String = ""

  func createUser() async throws  {
    try await AuthService.shared.createUser(email: email, password: password, fullName: fullname, phoneNumber: phonenumber)
  }

}
