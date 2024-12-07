//
//  NavigationBarColor.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 05/09/24.
//

import SwiftUI
struct NavigationBarColor : ViewModifier{

  var backgroundColor: Color
  init(backgroundColor: Color) {
    self.backgroundColor = backgroundColor
    let coloredAppearence = UINavigationBarAppearance()
    coloredAppearence.backgroundColor = UIColor(backgroundColor)
    UINavigationBar.appearance().standardAppearance = coloredAppearence
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearence
  }

  func body(content: Content) -> some View {
    content.background(backgroundColor)
  }
}

extension View {

  func navigationBarColor(backgroundColor: Color) -> some View {
  return modifier(NavigationBarColor(backgroundColor: backgroundColor))
  }

}
