//
//  NewMessageViewModel.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 15/09/24.
//

import Foundation
import Firebase

@MainActor
class NewMessageViewModel: ObservableObject {


  @Published var users =  [User]()

  init() {
    Task { try await self.fetchContacts()}
  }
   private func fetchContacts()  async throws  {
    let users = try await UserService.shared.fetchAllUsers()
    guard let currentUserId = Auth.auth().currentUser?.uid else { return }
    self.users = users.filter({ $0.id != currentUserId})
  }

}
