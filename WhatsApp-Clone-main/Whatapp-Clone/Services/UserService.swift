//
//  UserService.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 14/09/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserService {

    @Published var currentUser: User?
    static var shared = UserService()

    init()  {
        Task { try await fetchCurrentUser() }
    }

    @MainActor
    func fetchCurrentUser() async throws {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            currentUser = try snapshot.data(as: User.self)
        } catch {
            print("Failed to fetch user data")
        }
    }

    @MainActor
    func fetchAllUsers() async throws -> [User] {
        let snapshot = try await Firestore.firestore().collection("users").getDocuments()
        return snapshot.documents.compactMap { try? $0.data(as: User.self) }
    }

    func fetchUser(withUid uid: String, completion: @escaping (User?) -> ()) {
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }

    @MainActor
    func updateUserProfileImage(withimageUrl imageUrl: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore().collection("users").document(uid).updateData(["profileImageUrl": imageUrl])
        self.currentUser?.profileImageUrl = imageUrl
    }
}
