//
//  EmojiTextField.swift
//  Whatapp-Clone
//
//  Created by Neeraj Sharma on 16/09/24.
//

import UIKit
import SwiftUI


class UIEmojiTextField: UITextField {
  var isEmoji = false {
      didSet {
        self.reloadInputViews()
      }
  }

  override var textInputContextIdentifier: String? {
      return ""
  }
  override var textInputMode: UITextInputMode? {
      for mode in UITextInputMode.activeInputModes {
          if mode.primaryLanguage == "emoji" && self.isEmoji{
              self.keyboardType = .default
              return mode

          } else if !self.isEmoji {
              return mode
          }
      }
      return nil
  }

  override var intrinsicContentSize: CGSize {
    let size = self.sizeThatFits(CGSize(width: self.bounds.width, height: .greatestFiniteMagnitude))
    return CGSize(width: self.bounds.width, height: size.height)
  }

}


struct EmojiTextField: UIViewRepresentable {


  @Binding var text: String
  var placeholder: String = ""
  @Binding var isEmoji: Bool

  func makeUIView(context: Context) -> UIEmojiTextField {
    let emojiTextField = UIEmojiTextField()
    emojiTextField.placeholder = placeholder
    emojiTextField.isEmoji = isEmoji
    emojiTextField.text = text
    emojiTextField.delegate = context.coordinator
    return emojiTextField
  }

  func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
    uiView.text = text
    uiView.isEmoji = isEmoji
  }

  func makeCoordinator() -> Coordinator {
      Coordinator(parent: self)
  }

    class Coordinator: NSObject, UITextFieldDelegate {
    var parent: EmojiTextField

    init(parent: EmojiTextField) {
      self.parent = parent
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        parent.text = textField.text ?? ""
    }
  }

}
