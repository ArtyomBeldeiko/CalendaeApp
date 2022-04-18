//
//  QuoteViewController.swift
//  CalendaeApp
//
//  Created by Artyom Beldeiko on 8.07.21.
//

import UIKit
import Alamofire
import Lottie

class QuoteViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var pulsatingAnimation: AnimationView!
    @IBOutlet weak var backgroundAnimation: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AF.request("https://api.forismatic.com/api/1.0/?method=getQuote&key=457653&format=json&lang=en").responseData { [self] response in
            if let data = response.value {
                let quote = try? JSONDecoder().decode (Quote.self, from: data)
                quoteLabel.text = quote?.quoteText
            }
    
        }
//
                        let animationToShow = Animation.named("01")
                        pulsatingAnimation.animation = animationToShow

                        pulsatingAnimation.contentMode = .scaleAspectFit
                        pulsatingAnimation.loopMode = .loop
                        pulsatingAnimation.animationSpeed = 0.6
                        pulsatingAnimation.alpha = 0.8
                        pulsatingAnimation.play()

                        backgroundAnimation.contentMode = .scaleAspectFit
                        backgroundAnimation.loopMode = .loop
                        backgroundAnimation.animationSpeed = 0.2
                        backgroundAnimation.alpha = 0.9
                        backgroundAnimation.play()

    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        let mainVC = storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    

}
