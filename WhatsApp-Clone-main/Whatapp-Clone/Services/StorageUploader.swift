//
//  StorageUploader.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 16/09/24.
//

import Foundation
import Firebase
import FirebaseStorage


struct StorageUploader {

  static func uploadProfileImage(uiImage: UIImage) async throws -> String? {
    guard let imageData = uiImage.jpegData(compressionQuality: 0.25) else { return nil}
    let storageRef = Storage.storage().reference(withPath: "/profile_image/\(UUID().uuidString)")
    do  {
      _ = try await storageRef.putDataAsync(imageData)
      let url = try await storageRef.downloadURL()
      return url.absoluteString
    } catch {
      print("failed to upload image\(error.localizedDescription)")
      return nil
    }
  }

  static func uploadMessageImage(uiImage: UIImage) async throws -> String? {
    guard let imageData = uiImage.jpegData(compressionQuality: 0.25) else { return nil}
    let storageRef = Storage.storage().reference(withPath: "/message_image/\(UUID().uuidString)")
    do  {
      _ = try await storageRef.putDataAsync(imageData)
      let url = try await storageRef.downloadURL()
      return url.absoluteString
    } catch {
      print("failed to upload image\(error.localizedDescription)")
      return nil
    }
  }

  static func uploadVideo(withdata data: Data) async throws -> String? {
    let ref = Storage.storage().reference().child("/message_videos/\(UUID().uuidString)")
    let metaData = StorageMetadata()
    metaData.contentType = "video/quicktime"
    do {
      let _ = try await ref.putDataAsync(data,metadata: metaData)
      let url = try await ref.downloadURL()
      return url.absoluteString
    } catch {
      print("failed to upload video \(error.localizedDescription)")
      return nil
    }
  }

  static func uploadAudio(withUrl recordingUrl: URL) async throws -> String? {
    let ref = Storage.storage().reference().child("/message_audio/\(UUID().uuidString)")
    let metaData = StorageMetadata()
    metaData.contentType = "audio/m4a"
    do {
      let _ = try await ref.putFileAsync(from:  recordingUrl, metadata: metaData)
      let url = try await ref.downloadURL()
      return url.absoluteString
    } catch {
            print("failed to upload voice recording \(error.localizedDescription)")
            return nil
       }
    }
 }
