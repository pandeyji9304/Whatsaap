//
//  Whatapp_CloneApp.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 04/09/24.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
@main
struct Whatapp_CloneApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate 
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
