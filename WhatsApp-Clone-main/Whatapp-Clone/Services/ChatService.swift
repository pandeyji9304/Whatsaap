//
//  ChatService.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 15/09/24.
//

import Foundation
import Firebase



class ChatService {

  @Published var count: Int = 0

   func sendMessage(_ messageText: String,chatPartner: User,isImage: Bool,isVideo: Bool, isAudio: Bool) {
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    let chatPartnerId = chatPartner.id
    let currentUserRef = Firestore.firestore().collection("messages").document(currentUid).collection(chatPartnerId).document()
    let chatPartnerRef = Firestore.firestore().collection("messages").document(chatPartnerId).collection(currentUid)
    let latestCurrentUserRef = Firestore.firestore().collection("messages").document(currentUid).collection("latest-messages").document(chatPartnerId)
    let latestChatPartnerRef = Firestore.firestore().collection("messages").document(chatPartnerId).collection("latest-messages").document(currentUid)
    let documentId = currentUserRef.documentID
    let message = Message(messageId: documentId, fromId: currentUid, told: chatPartnerId, messageText: messageText, timeStamp: Timestamp(), isImage: isImage, isAudio: isAudio, isVideo: isVideo, user: nil)
    guard let messageData = try? Firestore.Encoder().encode(message) else { return }
    currentUserRef.setData(messageData)
    chatPartnerRef.document(documentId).setData(messageData)
    latestCurrentUserRef.setData(messageData)
    latestChatPartnerRef.setData(messageData)
    count += 1
  }
   func observeMessage(chatPartner: User,completion: @escaping ([Message]) -> Void) {
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    let query = Firestore.firestore().collection("messages").document(currentUid).collection(chatPartner.id).order(by: "timeStamp", descending: false)
    query.addSnapshotListener { snapshot, _ in
      guard let changes = snapshot?.documentChanges.filter({$0.type == .added})  else { return }
      var messages = changes.compactMap({ try? $0.document.data(as: Message.self)})
      for (index,message) in messages.enumerated() where  !message.isFromCurrentUser {
        messages[index].user =  chatPartner
      }
      DispatchQueue.main.async {
        self.count += 1
      }
      completion(messages)
    }
  }
}
