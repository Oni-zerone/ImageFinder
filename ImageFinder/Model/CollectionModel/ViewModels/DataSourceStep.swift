//
//  CollectionDataSource+DataStep.swift
//  ImageFinder
//
//  Created by Andrea Altea on 30/11/2018.
//  Copyright © 2018 Andrea Altea. All rights reserved.
//

import Foundation

class DataSourceStep: DataStep {
    
    var dataSource: CollectionDataSource
    
    init(dataSource: CollectionDataSource) {
        self.dataSource = dataSource
        super.init()
    }
    
    override func success(with model: CollectionModel) {
        
        DispatchQueue.main.async {
            self.dataSource.model = model
        }
    }
    
    override func failed(with error: Error) {
        
        self.reset()
    }
    
    override func reset() {
        
        DispatchQueue.main.async {
            self.dataSource.model = []
        }
    }
    
}
