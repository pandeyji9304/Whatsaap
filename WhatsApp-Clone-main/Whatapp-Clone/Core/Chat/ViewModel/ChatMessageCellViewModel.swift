//
//  ChatMessageCellViewModel.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 16/09/24.
//

import Foundation
import AVFAudio


class ChatMessageCellViewModel: ObservableObject {

  var audioPlayer: AVAudioPlayer?

  func playAudio(message: Message) async throws {
    guard let audioUrl = URL(string: message.messageText) else  {
      print("invalid url")
      return
    }
    let documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let localUrl = documentUrl.appendingPathComponent(audioUrl.lastPathComponent)
    if FileManager.default.fileExists(atPath: localUrl.path) {
      playSound(sound: localUrl.path)
    } else {
      let downloadTask = URLSession.shared.downloadTask(with: audioUrl) {(tempURL,_,error) in
        guard let tempUrl = tempURL, error == nil else {
            return
        } 
          do {
            try FileManager.default.moveItem(at: tempUrl, to: localUrl)
            DispatchQueue.main.async {
              self.playSound(sound: localUrl.path)
            }
          } catch {
            print("error movine file \(error.localizedDescription)")
          }
        }
      downloadTask.resume()
     }
   }

  func playSound(sound: String) {
    guard let url = URL(string: sound) else {
      print("invalid url")
      return
    } 
     do {
          audioPlayer = try AVAudioPlayer(contentsOf: url)
       audioPlayer?.play()
     } catch {
       print("error playing sound\(error.localizedDescription)")
     }
   }

}
