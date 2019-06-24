//
//  CardController.swift
//  DeckOfOneCard27
//
//  Created by Albert Yu on 6/24/19.
//  Copyright © 2019 AlbertLLC. All rights reserved.
//

import UIKit


class CardController {
    /**
    // static func printName() {
     a function you can call on the class itself
     */
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")
    
    
    static func drawCard(completion: @escaping (Card?) -> Void) {
        // Step 1 - Unwrap our optional base URL
        guard let url = baseURL else { completion(nil); return }
        
        // Step 2 - Construct your final URL
        // url.appendPathComponent("newCard")
        
        // Step 3 - Creat a URLRequest to get data from
        // let request = URLRequest(url: url)
        
        // Step 4 - Get the data from the URL request
        do {
            let data = try Data(contentsOf: url)
            
            let jDecoder = JSONDecoder()
            
            let topLevelJSON = try jDecoder.decode(TopLevelJSON.self, from: data)
            
            let card = topLevelJSON.cards[0]
            
            completion(card)
        } catch {
            print("Error getting data from URL")
            completion(nil)
            return
        }
    }
    
    
    static func getImageFor(card: Card, completion: (UIImage?) -> ()) {
        // Step 1 - Unwrap our optional URL
        guard let url = URL(string: card.image) else {completion(nil); return}
        
        // Step 2 - Construct your final URL
        // For this one, nothing
        
        // Step 3 - Create a URLRequest to get data from
        // let request = URLRequest(url: url)
        
        // Step 4 - Ge the data from the URL/URLRequest
        
        do {
            let data = try Data(contentsOf: url)
            
            let image = UIImage(data: data)
            
            completion(image)
        } catch {
            print("Error fetching image for card: \(card.code)")
            completion(nil)
            return
            
            
        }
    }
}
