//
//  ViewController.swift
//  BoredNoMore
//
//  Created by User on 8/31/20.
//  Copyright © 2020 Ryan Matsuo. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var randomActivityLabel: UILabel!
    
    var randomActivityUrl = K.randomActivityURL
    var urlSessionManager = URLSessionManager()
    var urlSessionResult = ActivityModel(activity: "", accessibility: 0.0, type: "", participants: 0, price: 0.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlSessionManager.delegate = self
        urlSessionManager.makeNetworkCall(url: randomActivityUrl)
        
        cardView.isUserInteractionEnabled = false
        cardView.layer.cornerRadius = 20.0
    }
    
    // MARK: - Card Panning Functionality
    
    @IBAction func activityCardMoved(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
            let point = sender.translation(in: view)
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            let xFromCenter = card.center.x - view.center.x
            
            let scale = min(100/abs(xFromCenter), 1)
            
            card.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            card.alpha = CGFloat(scale)
            
            if xFromCenter > 0 {
                cardImageView.image = UIImage(systemName: "plus.square.fill")
                cardImageView.tintColor = UIColor.systemGreen
            } else {
                cardImageView.image = UIImage(systemName: "xmark.circle.fill")
                cardImageView.tintColor = UIColor.systemRed
            }
            
            cardImageView.alpha = abs(xFromCenter) / view.center.x
            
            if sender.state == UIGestureRecognizer.State.ended {
                
                if card.center.x < 75 {
                    UIView.animate(withDuration: 0.4, animations: {
                        card.center = CGPoint(x: card.center.x - 300, y: card.center.y + 50)
                    }, completion: { finished in
                        self.resetCard()
                    })
                    
                return
                    
                } else if card.center.x > (view.frame.width - 75) {
                    UIView.animate(withDuration: 0.4, animations: {
                        card.center = CGPoint(x: card.center.x + 300, y: card.center.y + 50)
                    }, completion: { finished in
                        self.addToFavorites()
                        self.resetCard()
                    })
                    
                return
                }
                
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = self.view.center
                    card.alpha = 1.0
                    card.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.cardImageView.alpha = 0
                })
            }
        }

        func resetCard() {
            cardView.center = self.view.center
            cardView.alpha = 1.0
            cardView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            randomActivityLabel.text = K.defaultText
            cardImageView.alpha = 0
            cardView.isUserInteractionEnabled = false
            urlSessionManager.makeNetworkCall(url: randomActivityUrl)
            }
    
    func addToFavorites() {
    let tabBar = tabBarController as! BaseTabBarController
    tabBar.favoritesArray.append(urlSessionResult)
    tabBar.encodeData()
    }
}

//MARK: - HomeScreenViewController Extensions

extension HomeScreenViewController: URLSessionManagerDelegate {
    
    func didUpdateActivityLabel(activity: ActivityModel) {
        DispatchQueue.main.async {
            self.randomActivityLabel.text = activity.activity
            self.urlSessionResult = activity
            self.cardView.isUserInteractionEnabled = true
        }
    }
}




