//
//  ViewController.swift
//  Cat Gif
//
//  Created by Mohcine Belarrem on 31/05/2019.
//  Copyright © 2019 mohcine. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataReady), name:Notification.Name("dataReady") , object: nil)
        
        navigationItem.title = "Cats Gifs"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(GifManager.shared.gif(index:section).id)"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return GifManager.shared.listSize()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell")
        
        let gif = GifManager.shared.gif(index: indexPath.section)
        
        let textLabel = cell?.viewWithTag(101) as! UILabel
        textLabel.text = gif.id
        
        let subtitleLabel = cell?.viewWithTag(102) as! UILabel
        subtitleLabel.text = gif.source_url
        
        DispatchQueue.global().async {
            
            let url = URL(string:gif.url)
            
            if let imageData = try? Data.init(contentsOf: url!),
                let image = UIImage(data: imageData){
                
                DispatchQueue.main.async {
                    let imageview = cell?.viewWithTag(100) as! UIImageView
                    imageview.image = image
                   
                }
            }
        }
        
        return cell!
    }
    
    @objc func dataReady() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}

