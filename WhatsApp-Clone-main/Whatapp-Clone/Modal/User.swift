//
//  User.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 06/09/24.
//

import Foundation


struct User: Codable,Identifiable,Hashable {
  var id: String = UUID().uuidString
  let fullname: String
  let email: String
  let phoneNumber: String
  var profileImageUrl: String?

}

extension User {

  static let MOCK_USER = User(fullname: "Wanda Maximoff", email: "wanda.maximoff@gmail.com", phoneNumber: "+987654321",profileImageUrl: nil)

}
