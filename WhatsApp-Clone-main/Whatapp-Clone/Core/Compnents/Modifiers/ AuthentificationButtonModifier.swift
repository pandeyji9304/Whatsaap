//
//   AuthentificationButtonModifier.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 13/09/24.
//

import SwiftUI


struct AuthentificationButtonModifier: ViewModifier {

  func body(content: Content) -> some View {
    content
      .font(.subheadline)
      .fontWeight(.semibold)
      .foregroundStyle(.white)
      .frame(width: 360, height: 44)
      .background(.green)
      .clipShape(RoundedRectangle(cornerRadius: 10))

  }

}

extension View {
  func authentificationButtonModifier() -> some View {
    return modifier(AuthentificationButtonModifier())
  }
}
