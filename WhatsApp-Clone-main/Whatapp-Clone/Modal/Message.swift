//
//  Message.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 08/09/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Message: Identifiable,Hashable,Codable {

  @DocumentID var messageId: String?
  let fromId: String
  let told: String
  let messageText: String
  let timeStamp: Timestamp
  let isImage: Bool
  let isAudio: Bool
  let isVideo: Bool
  var user : User?
  var id: String {
    return messageId ??  UUID().uuidString
  }
  var chatPartnerId: String {
    return fromId == Auth.auth().currentUser?.uid ? told : fromId
  }
  var isFromCurrentUser: Bool {
    return fromId == Auth.auth().currentUser?.uid
  }
}

struct MessageGroup: Identifiable,Hashable{

  var id = UUID().uuidString
  var messages: [Message]
  let date: Date

}

extension MessageGroup{

  static let MOCK_MESSAGE_GROUP = [MessageGroup(messages: [Message(fromId: "", told: "", messageText: "Hello Mr Dwight", timeStamp: Timestamp(), isImage: false, isAudio: false, isVideo: false, user: nil),Message(fromId: "", told: "", messageText: "Hello Mr Dwight", timeStamp: Timestamp(), isImage: false, isAudio: false, isVideo: false, user: nil),Message(fromId: "", told: "", messageText: "Hello Mr Dwight", timeStamp: Timestamp(), isImage: false, isAudio: false, isVideo: false, user: nil),Message(fromId: "", told: "", messageText: "Hello Mr Dwight", timeStamp: Timestamp(), isImage: false, isAudio: false, isVideo: false, user: nil),Message(fromId: "", told: "", messageText: "Hello Mr Dwight", timeStamp: Timestamp(), isImage: false, isAudio: false, isVideo: false, user: nil) ], date: Date())]
}
