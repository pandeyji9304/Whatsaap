//
//  MainTabbarView.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 05/09/24.
//

import SwiftUI

struct MainTabbarView: View {
    @State private var selectedTab: Int = 0
    var body: some View {
        TabView {
            InboxView()
                .tabItem {
                    VStack {
                        Image(systemName: "text.bubble.fill")
                            .environment(\.symbolVariants,selectedTab == 0 ? .fill : .none)
                        Text("Chats")
                    }
                }
                .onAppear{
                    selectedTab = 0
                }
            Text("Updates")
                .tabItem {
                    VStack {
                        Image(systemName: "dial.low")
                            .environment(\.symbolVariants,selectedTab == 1 ? .fill : .none)
                        Text("Updates")
                    }
                }
                .onAppear{
                    selectedTab = 1
                }

            Text("Communities")
                .tabItem {
                    VStack {
                        Image(systemName: "person.3")
                            .environment(\.symbolVariants,selectedTab == 2 ? .fill : .none)
                        Text("Communities")
                    }
                }
                .onAppear{
                    selectedTab = 2
                }
            Text("Calls")
                .tabItem {
                    VStack {
                        Image(systemName: "phone")
                            .environment(\.symbolVariants,selectedTab == 3 ? .fill : .none)
                        Text("Calls")
                    }
                }
                .onAppear{
                    selectedTab = 3
                }
        }
        .tint(.black)
    }
}

struct MainTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbarView()
    }
}
