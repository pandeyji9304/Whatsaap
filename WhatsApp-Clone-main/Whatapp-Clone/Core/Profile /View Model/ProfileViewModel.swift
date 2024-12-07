//
//  ProfileViewModel.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 13/09/24.
//

import SwiftUI
import PhotosUI

class ProfileViewModel: ObservableObject {
  @Published var tabbarVisibality: Visibility = .hidden
  @Published var showPhotoPicker: Bool = false
  @Published var profileImage: Image?
  @Published var selectedImage: PhotosPickerItem? {
    didSet {
      Task { try await loadImage(withItem: selectedImage) }
    }
  }

  private func loadImage(withItem item: PhotosPickerItem?) async throws {
    guard let item = item else { return }
    guard let data = try await item.loadTransferable(type: Data.self) else { return }
    guard let uiImage = UIImage(data: data) else { return } 
    self.profileImage = Image(uiImage: uiImage)
    try await updateProfileImage(uiImage: uiImage )
  }
   private func updateProfileImage(uiImage: UIImage) async throws  {
     guard let imageUrl = try await StorageUploader.uploadProfileImage(uiImage: uiImage)  else { return }
     try await UserService.shared.updateUserProfileImage(withimageUrl: imageUrl)

  }

}


