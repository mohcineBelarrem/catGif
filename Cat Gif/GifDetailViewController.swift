//
//  GifDetailViewController.swift
//  Cat Gif
//
//  Created by Mohcine Belarrem on 31/05/2019.
//  Copyright © 2019 mohcine. All rights reserved.
//

import UIKit

class GifDetailViewController: UIViewController {
    
    public var gif : CatGif!
    public var text : String!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = gif.id
        textView.text = text
        
        DispatchQueue.global().async {
            let url = URL(string:self.gif.url)
            
            if let imageData = try? Data.init(contentsOf: url!),
                let image = UIImage(data: imageData){
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                    
                }
            }
        }
    }
    
    
    
    
}
