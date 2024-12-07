//
//  SettingsViewModel.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 13/09/24.
//

import SwiftUI


class SettingsViewModel: ObservableObject {

  @Published var tabbarVisibility: Visibility = .hidden

  func logout()  {
    AuthService.shared.logout()

  }

}
