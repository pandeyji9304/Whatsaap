//
//  RootView.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 14/09/24.
//

import SwiftUI

struct RootView: View {
  @StateObject private var viewModel = RootViewModel()
    var body: some View {
      Group {
        if viewModel.userSession != nil {
            InboxView()
        } else {
            WelcomeView()
         }
       }
    }
}

#Preview {
    RootView()
}
