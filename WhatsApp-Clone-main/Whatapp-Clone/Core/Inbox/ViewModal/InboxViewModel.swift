//
//  InboxViewModel.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 06/09/24.
//

import Foundation
import Combine
import Firebase


class InboxViewModel: ObservableObject {

  @Published var showNewMessage: Bool = false
  @Published var latestMessages = [Message]()
  @Published var currentUser: User?
  @Published var showChat: Bool = false
  private var  indoxService = InboxService()
  private var cancellables = Set<AnyCancellable>()


  init() {
    setupSubscriptions()
    indoxService.observeLatestMessages()
  }

  private func setupSubscriptions() {
    UserService.shared.$currentUser.sink { [weak self] currentUser in
      self?.currentUser = currentUser

    }
    .store(in: &cancellables)
    indoxService.$documentChanges.sink { [weak self] changes in
      self?.loadInitialMessages(withChanges: changes)
    }.store(in: &cancellables)
  }
  private func loadInitialMessages(withChanges  changes: [DocumentChange] ) {
    var messages = changes.compactMap({ try? $0.document.data(as: Message.self)})
      for i in 0 ..< messages.count {
        UserService.shared.fetchUser(withUid: messages[i].chatPartnerId) { user in
          messages[i].user = user
          if let userIndexInLatestMessages = self.latestMessages.lastIndex(where: {$0.user == messages[i].user}) {
            self.latestMessages.remove(at: userIndexInLatestMessages)
        }
          self.latestMessages.insert(messages[i], at: 0)
      }
    }
  }
}
