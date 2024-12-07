//
//  ContectView.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 06/09/24.
//

import SwiftUI


struct ContectView: View {
  private var imageName: String
  private var title: String
  init(imageName: String, title: String) {
    self.imageName = imageName
    self.title = title
  }
  var body: some View {
    HStack(spacing: 16) {
      Image(systemName: imageName)
        .resizable()
        .frame(width: 40,height: 40)
        .foregroundStyle(.gray)
      Text(title)
        .font(.subheadline)
        .fontWeight(.semibold)
      Spacer()
    }
  }
}
