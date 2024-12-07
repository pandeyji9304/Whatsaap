//
//  RootViewModel.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 14/09/24.
//

import Foundation
import FirebaseAuth
import Combine

class RootViewModel: ObservableObject {


    @Published var userSession: FirebaseAuth.User?


    private var cancellables = Set<AnyCancellable>()

    init() {
        setupSubscribers()
    }

    private func setupSubscribers() {

        AuthService.shared.$userSession.sink { [weak self] userSession in
                 self?.userSession = userSession
            }
            .store(in: &cancellables)
    }
}
