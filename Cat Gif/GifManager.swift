//
//  GifManager.swift
//  Cat Gif
//
//  Created by Mohcine Belarrem on 31/05/2019.
//  Copyright © 2019 mohcine. All rights reserved.
//

import Foundation


///This will be our base struct, following the JSon Pattern
struct CatGif : Decodable {
    let id : String
    let url : String
    let source_url : String
    
}

final class GifManager {
    private init() {}
    static let shared = GifManager()
    
    private var gifsList = [CatGif]()
    
    
    func getGifsData(numberOfGifs : Int) {
        
        if !gifsList.isEmpty {
            gifsList.removeAll(keepingCapacity: false)
        }
        
        let stringUrl = "https://api.thecatapi.com/api/images/get?format=json&type=gif"
        guard let Url = URL(string: stringUrl) else {
            return
        }
        
        
        for _ in 1...numberOfGifs {
        
        URLSession.shared.dataTask(with: Url) {[weak self] (data,response,error) in
            
            do {
                
                   let gifArray  = try JSONDecoder().decode([CatGif].self, from: data ?? Data())
                    
                    self?.gifsList.append(gifArray.first!)
                    
                if self?.gifsList.count == numberOfGifs {
                    let notification = Notification(name: Notification.Name("dataReady"))
                    NotificationCenter.default.post(notification)
                }
                
            } catch {
                print("Something Went wrong while parsing data.")
            }
            
            }.resume()
            
        }
    }
    
    func listSize() -> Int {
        return gifsList.count
    }
    
    func gif(index : Int) -> CatGif {
        return gifsList[index]
    }
    
    func text() -> String {
        
        let textStringUrl = "https://loripsum.net/api"
        guard let textUrl = URL(string: textStringUrl) else {
            return ""
        }
        
        do {
        let text = try String(contentsOf: textUrl)
        return text
        }
        
        catch {
            return ""
        }
        
        
    }
    
    func printList() {
        
        for gif in gifsList {
            
            print("\(gif.id) \(gif.url)")
            
        }
    }
    
}
