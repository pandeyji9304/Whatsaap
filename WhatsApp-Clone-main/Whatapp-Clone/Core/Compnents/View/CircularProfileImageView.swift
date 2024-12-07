//
//  CircularProfileImageView.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 06/09/24.
//

import SwiftUI
import Kingfisher


enum ProfileImageSize {

    case xxsmall
    case xsmall
    case small
    case medium
    case large
    case xlarge
    case xxlarge


  var dimensions: CGFloat {
    switch self {
    case .xxsmall:
      return 28
    case .xsmall:
      return 32
    case .small:
      return 40
    case .medium:
      return 56
    case .large:
      return 64
    case .xlarge:
      return 80
    case .xxlarge:
      return 120

    }
  }


}

struct CircularProfileImageView: View {
  private let size: ProfileImageSize
  var user: User?
  init(size: ProfileImageSize,user: User?) {
    self.size = size
    self.user = user
  }
  var body: some View {
    if let profileImageUrl = user?.profileImageUrl {
     KFImage(URL(string: profileImageUrl ))
        .resizable()
        .frame(width: size.dimensions,height: size.dimensions)
        .scaledToFill()
        .clipShape(Circle())
    } else {
      Image(systemName: "person.circle.fill")
        .resizable()
        .frame(width: size.dimensions,height: size.dimensions)
        .foregroundStyle(Color(.systemGray4))
    }
  }
}

#Preview {
  CircularProfileImageView(size: .medium, user: nil)
}
