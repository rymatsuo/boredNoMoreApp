//
//  ActivityModel.swift
//  Bored-No-More
//
//  Created by User on 7/17/20.
//

import Foundation

struct ActivityModel: Codable {
    
    var activity: String
    var accessibility: Float
    var type: String
    var participants: Int
    var price: Float
    
    var done: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case activity
        case accessibility
        case type
        case participants
        case price
    }
    
}
