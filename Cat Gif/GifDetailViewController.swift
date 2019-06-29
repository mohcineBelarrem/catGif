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
    public var image : UIImage!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = gif.id
        
        DispatchQueue.global().async {
        
        self.text = GifManager.shared.text()
        
        let fullPage = "<!DOCTYPE html> <html> <head> <style> p{font-size: 20px;; text-align: justify;} </style> </head> <h1>\(self.gif.id)</h1> <body>"+self.text+"</body></html>"
        
        let htmlData = NSString(string: fullPage).data(using: String.Encoding.utf8.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
        let attributedString = try! NSAttributedString(data: htmlData!,
                                                       options: options,
                                                       documentAttributes: nil)
        
            DispatchQueue.main.async {
                self.textView.attributedText = attributedString
            }
        }
        
        
        self.imageView.image = self.image
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.textView.flashScrollIndicators()
        self.textView.setContentOffset(.zero, animated: true)
    }
    
}
