//
//  URLSessionManager.swift
//  Bored-No-More
//
//  Created by User on 7/17/20.
//

import Foundation

protocol URLSessionManagerDelegate {
    func didUpdateActivityLabel(activity: ActivityModel)
}

struct URLSessionManager {
    
    let url = "http://www.boredapi.com/api/"
    
    var delegate: URLSessionManagerDelegate?
    
    func makeNetworkCall(url: String) {
        
        //1. Create URL
        if let url = URL(string: url) {
            
        //2. Create URL Session
            let session = URLSession(configuration: .default)
        //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let activity = self.parseJSON(activityData: safeData) {
                        self.delegate?.didUpdateActivityLabel(activity: activity)
                    }
                }
            }
        //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(activityData: Data) -> ActivityModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ActivityModel.self, from: activityData)
            
            let activity = decodedData.activity
            let accessibility = decodedData.accessibility
            let type = decodedData.type
            let participants = decodedData.participants
            let price = decodedData.price
            
            let done = false
            
            let model = ActivityModel(activity: activity, accessibility: accessibility, type: type, participants: participants, price: price, done: done)
            
            return model
            
        } catch {
            print(error)
            return nil
        }
        
    }
}
