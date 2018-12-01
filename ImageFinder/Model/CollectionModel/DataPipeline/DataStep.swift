//
//  DataStep.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

enum Result {
    
    case value(CollectionModel)
    case error(_ error: Error)
    case reset
}


class DataStep {
    
    fileprivate weak var nextStep: DataStep?
    
    fileprivate func loadContent(from baseContent: Result) {
        
        switch baseContent {
            
        case .error(let error):
            self.failed(with: error)
            
        case .value(let model):
            self.success(with: model)
            
        case .reset:
            self.reset()
        }
    }
    
    func success(with model: CollectionModel) {
        self.sendContent(.value(model))
    }
    
    func failed(with error: Error) {
        self.sendContent(.error(error))
    }
    
    func reset() {
        self.sendContent(.reset)
    }
    
    func sendContent(_ content: Result) {
        self.nextStep?.loadContent(from: content)
    }
}

struct Pipeline {
    
    internal var steps: [DataStep] = []
    
    mutating func append(_ dataStep: DataStep) {
        
        if let last = steps.last {
             last.nextStep = dataStep
        }
        self.steps.append(dataStep)
    }
    
    func reset() {
        self.steps.first?.loadContent(from: .reset)
    }
    
    func start() {
        self.steps.first?.loadContent(from: .value([]))
    }
}
