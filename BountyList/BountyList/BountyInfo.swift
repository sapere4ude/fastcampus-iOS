//
//  bountyInfo.swift
//  BountyList
//
//  Created by sapere4ude on 2020/12/02.
//

import UIKit

// MARK: - Model
struct BountyInfo {
    let name: String
    let bounty: Int
    
    var image: UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init(name: String, bounty: Int) {
        self.name = name
        self.bounty = bounty
    }
}
