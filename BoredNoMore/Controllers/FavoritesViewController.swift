//
//  ViewController.swift
//  Bored-No-More
//
//  Created by User on 7/16/20.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var FavoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FavoritesTableView.dataSource = self
        FavoritesTableView.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        FavoritesTableView.reloadData()
    }
}

// MARK: - Favorites View Controller Extensions (UITableViewDataSource Delegate)
extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tabBar = tabBarController as! BaseTabBarController
        return tabBar.favoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FavoritesTableView.dequeueReusableCell(withIdentifier: K.favoritesCell, for: indexPath)
        
        let tabBar = tabBarController as! BaseTabBarController
        let tabBarText = tabBar.favoritesArray[indexPath.row].activity
        let tabBarDoneStatus = tabBar.favoritesArray[indexPath.row].done
        
        cell.textLabel?.text = tabBarText
        cell.accessoryType = tabBarDoneStatus ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tabBar = tabBarController as! BaseTabBarController
        let tabBarDoneStatus = tabBar.favoritesArray[indexPath.row].done
        tabBar.favoritesArray[indexPath.row].done = !tabBarDoneStatus
        
        tabBar.encodeData()
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: (Bool) -> Void) in
            let tabBar = self.tabBarController as! BaseTabBarController
            tabBar.favoritesArray.remove(at: indexPath.row)
            tabBar.encodeData()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
