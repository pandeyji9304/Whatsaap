//
//  ChatMessageCell.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 07/09/24.
//

import SwiftUI
import Kingfisher
import AVKit

struct ChatMessageCell: View {
  let isFromCurrentUser : Bool
  let message: Message
  @StateObject private var viewModel = ChatMessageCellViewModel()
    var body: some View {
      if isFromCurrentUser {
        VStack(alignment: .leading,spacing: message.isImage || message.isVideo || message.isAudio ? 0 : -15) {
        if message.isImage {
          KFImage(URL(string: message.messageText))
            .resizable()
            .frame(width: 100,height: 180)
            .scaledToFill()
            .padding(.horizontal)
            .padding(.top,6)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        } else if message.isVideo {
          if let videoUrl = URL(string: message.messageText) {
            VideoPlayer(player: AVPlayer(url: videoUrl))
              .frame(width: 150,height: 150)
              .padding(.horizontal)
              .padding(.top,6)
              .clipShape(RoundedRectangle(cornerRadius: 15))
          }
        } else if message.isAudio {
          Button(action: {
            Task { try await viewModel.playAudio(message: message)}
          }, label: {
            Image("voice")
              .resizable()
              .frame(width: 100, height: 20)
              .scaledToFill()
              .padding(.horizontal)

          })

       } else {
          Text(message.messageText)
        }
            HStack{
              if message.isImage {
                  Spacer()
                  .frame(width: 99)

              } else if message.isVideo {
                Spacer()
                .frame(width: 148)
              } else if message.isAudio {
                  Spacer()
                  .frame(width: 94)
              } else {
                Text(message.messageText)
                  .foregroundStyle(.clear)
                  .lineLimit(1)
              }
              Text(message.timeStamp.dateValue().timeString())
                .foregroundStyle(.gray)
                .font(.footnote)

            }
          }
          .font(.subheadline)
          .padding(message.isImage  || message.isVideo || message.isAudio ? 1 : 12)
          .background(Color("Peach"))
          .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
          .frame(maxWidth: .infinity,alignment: .trailing)
          .padding(.horizontal)
        } else {
        HStack(spacing:8) {
          CircularProfileImageView(size:  .xxsmall, user: User.MOCK_USER)

          VStack(alignment: .leading,spacing: message.isImage || message.isVideo || message.isAudio ? 0 : -15) {
              if message.isImage {
                KFImage(URL(string: message.messageText))
                  .resizable()
                  .frame(width: 100,height: 180)
                  .scaledToFill()
                  .padding(.horizontal)
                  .padding(.top,6)
                  .clipShape(RoundedRectangle(cornerRadius: 15))
              } else if message.isVideo {
                if let videoUrl = URL(string: message.messageText) {
                  VideoPlayer(player: AVPlayer(url: videoUrl))
                    .frame(width: 150,height: 150)
                    .padding(.horizontal)
                    .padding(.top,6)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
              } else if message.isAudio {
                Button(action: {
                  Task { try await viewModel.playAudio(message: message)}
                }, label: {
                  Image("voice")
                    .resizable()
                    .frame(width: 100, height: 20)
                    .scaledToFill()
                    .padding(.horizontal)

                })

             }   else {
                Text(message.messageText)
              }
             HStack{
               if message.isImage {
                 Spacer()
                   .frame(width: 99)
               } else if message.isVideo {
                 Spacer()
                 .frame(width: 148)
                } else if message.isAudio {
                  Spacer()
                  .frame(width: 94)
                }  else {
                 Text(message.messageText)
                   .foregroundStyle(.clear)
                   .lineLimit(1)
               }
               Text(message.timeStamp.dateValue().timeString())
                  .foregroundStyle(.gray)
                  .font(.footnote)
                  .padding(.trailing,message.isImage || message.isVideo || message.isAudio ? 5 : 0)
              }
            }
            .font(.subheadline)
            .padding(message.isImage || message.isVideo || message.isAudio ? 1 : 12)
            .background(.white)
            .clipShape(ChatBubble(isFromCurrentUser: isFromCurrentUser))
            .frame(maxWidth: .infinity,alignment: .leading)
           }
          .padding(.horizontal)
        }
    }
}

#Preview {
  ChatMessageCell(isFromCurrentUser: Bool.random(), message: MessageGroup.MOCK_MESSAGE_GROUP.first!.messages.first!)
}

