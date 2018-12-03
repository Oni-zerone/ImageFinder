//
//  FailureMessageDataStep.swift
//  ImageFinder
//
//  Created by Andrea Altea on 03/12/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import UIKit

class FailureMessageDataStep: DataStep {
    
    override func failed(with error: Error) {
        
        let messageViewModel = MessageViewModel(message: error.localizedDescription)
        let section = MessageSectionViewModel(extendedTopMargin: true, items: [messageViewModel])
        
        self.sendContent(.value([section]))
    }
}
