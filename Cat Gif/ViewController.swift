//
//  ViewController.swift
//  Cat Gif
//
//  Created by Mohcine Belarrem on 31/05/2019.
//  Copyright © 2019 mohcine. All rights reserved.
//

import UIKit


class GifCell : UITableViewCell {
    
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndexPath : IndexPath!
    
    var refreshControl : UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(dataReady), name:Notification.Name("dataReady") , object: nil)
        
        navigationItem.title = "Cats Gifs"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        refreshControl = UIRefreshControl()
        
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    @objc @IBAction func refresh(_ sender: Any) {
        GifManager.shared.getGifsData(numberOfGifs: 100)
        self.tableView.reloadData()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell") as! GifCell
        
        let gif = GifManager.shared.gif(index: indexPath.section)
        
        cell.titleLabel.text = gif.id
        
        cell.detailLabel.text = gif.source_url
        
        DispatchQueue.global().async {
            
            let image = UIImage.gifImageWithURL(gifUrl: gif.url)
            
                DispatchQueue.main.async {
                    cell.gifImageView.image = image
                   
                }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showGifDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGifDetail" {
            let destination = segue.destination as! GifDetailViewController
            destination.gif = GifManager.shared.gif(index: selectedIndexPath.section)
            destination.text = GifManager.shared.text(index: selectedIndexPath.section)
        }
    }
    
    @objc func dataReady() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        
    }
    
    
    
}

