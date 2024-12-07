//
//  IndoxService.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 15/09/24.
//

import Foundation
import Firebase

class InboxService {

  @Published var documentChanges = [DocumentChange]()

  func observeLatestMessages() {
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    let query = Firestore.firestore().collection("messages").document(currentUid).collection("latest-messages").order(by: "timeStamp", descending: true)
      query.addSnapshotListener { snapshot, _ in
      guard let changes = snapshot?.documentChanges.filter({$0.type == .added || $0.type == .modified}) else { return }
        self.documentChanges = changes
        }
      }


  }
