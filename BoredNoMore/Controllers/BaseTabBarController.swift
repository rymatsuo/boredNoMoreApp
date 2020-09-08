//
//  TabBarController.swift
//  Bored-No-More
//
//  Created by User on 8/5/20.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    var favoritesArray: [ActivityModel] = []
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Favorites.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFavorites()

    }
    
    func encodeData() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(favoritesArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding array, \(error)")
        }
    }
    
    func loadFavorites() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            favoritesArray = try decoder.decode([ActivityModel].self, from: data)
            } catch {
                print("Error decoding array, \(error)")
            }
        }
    }
}
