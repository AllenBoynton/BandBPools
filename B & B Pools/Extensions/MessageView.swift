//
//  MessageView.swift
//  BandBPools
//
//  Created by Allen Boynton on 7/29/18.
//  Copyright © 2018 Allen Boynton. All rights reserved.
//

import UIKit
import SwiftMessages

extension MessageView {
    func createMessage() {
        let view = MessageView.viewFromNib(layout: .cardView)
        
        view.configureTheme(.success)
        
        // Add a drop shadow.
        view.configureDropShadow()
        
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        let iconText = ["🤔", "😳", "🙄", "😶", "😎", "🤪", "🙂", "🤗", "🤩", "🤨", "😐", "😑", "😏", "🤐", "😯", "😌", "😛", "😜", "🤑", "😲", "😇", "🤠", "🤡", "🤫",  "🧐", "🤓", "🤖", "🤲", "👐", "🙌", "👏", "🤝", "👍", "👊", "✊", "🤛", "🤜",  "✌️", "🤟", "🤘", "👌", "🖐", "🖖", "👋", "🤙", "💪", "💃🏻", "🕺🏻", "🚜", "⛱", "🏖", "🏝", "🏊‍♂️ ", "🏄🏿‍♂️"].sm_random()!
        view.configureContent(title: "Success", body: "You are logged in!", iconText: iconText)
        view.button?.isHidden = true
        
        SwiftMessages.show(view: view) // config: config,
    }
}
