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
            let image = UIImage.gifImageWithURL(gifUrl: self.gif.url)
            
            DispatchQueue.main.async {
                self.imageView.image = image
                
            }
            
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.textView.flashScrollIndicators()
    }
    
}
