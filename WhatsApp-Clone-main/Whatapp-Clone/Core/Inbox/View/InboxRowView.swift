//
//  InboxRowView.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 05/09/24.
//

import SwiftUI

struct InboxRowView: View {
 private var width: CGFloat
  private var message: Message
  init(width: CGFloat,message: Message) {
    self.width = width
    self.message = message
  }
    var body: some View {
      HStack(spacing: 12 ) {
        CircularProfileImageView(size: .medium, user: message.user)
        VStack(alignment: .leading, spacing: 4) {
          Text(message.user?.fullname ?? "")
            .fontWeight(.semibold)
          if message.isImage {
            Text("Sent picture")
              .foregroundStyle(.gray)
              .lineLimit(2)
              .frame(maxWidth: width - 100, alignment: .leading)
          } else  if message.isVideo{
            Text("Sent video")
              .foregroundStyle(.gray)
              .lineLimit(2)
              .frame(maxWidth: width - 100, alignment: .leading)
          }  else if message.isAudio {
            Text("Sent voice recording")
              .foregroundStyle(.gray)
              .lineLimit(2)
              .frame(maxWidth: width - 100, alignment: .leading)
          } else {
            Text(message.messageText)
              .foregroundStyle(.gray)
              .lineLimit(2)
              .frame(maxWidth: width - 100, alignment: .leading)

          }
      }
        .font(.subheadline)
        HStack{
          Text(message.timeStamp.dateValue().timeStampString())
          Image(systemName: "chevron.right")
        }
        .font(.footnote)
        .foregroundColor(.gray)
       }
      .frame(height: 72)
    }
}

//#Preview {
//  InboxRowView(width: 300)
//}
