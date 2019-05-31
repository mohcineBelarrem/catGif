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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = gif.id
        
        let fullPage = "<!DOCTYPE html> <html> <head> <style> p{font-size: 20px;; text-align: justify;} </style> </head> <h1>\(gif.id)</h1> <body>"+text+"</body></html>"
        
        let htmlData = NSString(string: fullPage).data(using: String.Encoding.utf8.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
        let attributedString = try! NSAttributedString(data: htmlData!,
                                                       options: options,
                                                       documentAttributes: nil)
        
        textView.attributedText = attributedString
        
        DispatchQueue.global().async {
            
            let image = UIImage.gifImageWithURL(gifUrl: self.gif.url)
            
            DispatchQueue.main.async {
                self.imageView.image = image
                self.activityIndicator.stopAnimating()
                self.imageView .isHidden = false
                self.activityIndicator.isHidden = true
            }
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.textView.flashScrollIndicators()
        self.textView.setContentOffset(.zero, animated: true)
    }
    
}
