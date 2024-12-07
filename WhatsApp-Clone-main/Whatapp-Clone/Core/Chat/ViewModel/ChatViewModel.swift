//
//  ChatViewModel.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 06/09/24.
//

import SwiftUI
import Combine
import PhotosUI
import AVFoundation


class ChatViewModel: ObservableObject{

  @Published var isEmoji: Bool = false
  @Published var audioRecorder: AVAudioRecorder?
  @Published var isRecording: Bool = false
  @Published var recordingURL: URL?
  @Published var messageText: String = ""
  @Published var chatPartner: User
  @Published var messageGroups = [MessageGroup]()
  @Published var count: Int = 0 
  private var service = ChatService()
  private var cancellables = Set<AnyCancellable>()
  @Published var showPhotoPicker: Bool = false
  @Published var showVideoPicker: Bool = false
  @Published var selectedImage: PhotosPickerItem? {
    didSet { Task {try await loadImage(fromItem: selectedImage)} }
  }
  @Published var selectedVideo: PhotosPickerItem? {
    didSet{
      Task { try await loadVideo() }
    }
  }
  @Published var messageImage: Image = Image("")
  @Published var tabbarVisibilty:  Visibility =  .hidden

  init(chatPartner: User) {
    self.chatPartner = chatPartner
    observeMessages()
    setupSubscribers()
  }

  private func setupSubscribers() {
    service.$count.sink { [weak self] count in
      self?.count = count
    }
    .store(in: &cancellables)
  }

  private func loadImage(fromItem item: PhotosPickerItem?) async throws{
       guard let item = item else { return }
       guard let data = try? await item.loadTransferable(type: Data.self) else { return }
       guard let uiImage = UIImage(data: data) else { return }
       self.messageImage = Image(uiImage: uiImage)
       try await updateMessageImage(withUiImage: uiImage)
  }

   private func loadVideo() async throws {
     guard let item = selectedVideo else { return }
     guard let data = try? await item.loadTransferable(type: Data.self) else { return }
     try await updateMessageVideo(withData: data)

  }
      func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
          try audioSession.setCategory(.record, mode: .default)
          try audioSession.setActive(true)
          let audioFileName =  getDocumentDirectory().appendingPathComponent("recording.m4a")
          let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
          ]
          audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
          audioRecorder?.record()
          isRecording = true
          recordingURL = audioFileName
        } catch {
          print("error starting recording \(error.localizedDescription)")
        }

  }

  func getDocumentDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }



    func finishRecording()  async throws {
      audioRecorder?.stop()
      isRecording = false
      try await updateMessageVoiceRecorded()
  }

  private func updateMessageImage(withUiImage uiImage: UIImage) async throws {
    guard let imageUrl = try? await StorageUploader.uploadMessageImage(uiImage: uiImage) else { return }
    service.sendMessage(imageUrl, chatPartner: chatPartner, isImage: true, isVideo: false, isAudio: false)
  }

  private func updateMessageVideo(withData data: Data) async throws {
    guard let videoUrl = try await StorageUploader.uploadVideo(withdata: data) else { return }
    service.sendMessage(videoUrl, chatPartner: chatPartner, isImage: false, isVideo: true, isAudio: false)
  }

   private func updateMessageVoiceRecorded()  async throws {
     guard let recordingURL = recordingURL else { return }
     guard let audioUrl = try? await StorageUploader.uploadAudio(withUrl: recordingURL)  else { return }
     service.sendMessage(audioUrl, chatPartner: chatPartner, isImage: false, isVideo: false, isAudio: true)
  }


   func sendMessage(chatPartner: User, isImage: Bool, isVideo: Bool, isAudio: Bool) {
    service.sendMessage(messageText, chatPartner: chatPartner, isImage: isImage, isVideo: isVideo, isAudio: isAudio)
     messageText = ""
  }

  func observeMessages() {
    service.observeMessage(chatPartner: chatPartner) { messages in
//      self.messageGroups.append(MessageGroup(messages: messages, date: Date()))
     let groupedMessages = self.groupMessageByDate(messages: messages)
      for group in groupedMessages {
        if let groupDateIndex = self.messageGroups.firstIndex(where: {$0.date == group.date})  {
          self.messageGroups[groupDateIndex].messages.append(contentsOf: group.messages)
        } else {
          self.messageGroups.append(group)
        }
      }
    }
  }
  private func groupMessageByDate(messages: [Message]) -> [MessageGroup] {
    var groupedMessages = [Date: [Message]]()
    for message in messages {
      let messageDate = Calendar.current.startOfDay(for: message.timeStamp.dateValue())
      if groupedMessages[messageDate] == nil {
           groupedMessages[messageDate] = [message]
      } else {
        groupedMessages[messageDate]?.append(message)
      }
    }
    return groupedMessages.map { (date,messages) in
       MessageGroup(messages: messages, date: date)
    }
    .sorted{$0.date < $1.date}
  }
}
