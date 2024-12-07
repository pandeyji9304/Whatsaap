//
//  ChatBubble.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 07/09/24.
//

import SwiftUI


struct ChatBubble: Shape{

  let isFromCurrentUser:  Bool

  func path(in rect: CGRect) -> Path {
    let path  =  UIBezierPath(roundedRect: rect, byRoundingCorners: [.topRight,.topLeft,isFromCurrentUser ?.bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))

    return Path(path.cgPath)


     }


  }
