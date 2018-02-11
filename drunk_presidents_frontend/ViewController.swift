//
//  ViewController.swift
//  drunk_presidents_frontend
//
//  Created by Tony Cioara on 1/17/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

// FIXME: Add comments

// This enum might be able to handle more..
// names and images ...

enum President: Int {
    case Washington = 0
    case Lincoln = 1
    case FDR = 2
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let president_count = 3
    var president: President?
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toQuote" {
                let quoteViewController = segue.destination as! QuoteViewController
                quoteViewController.president = self.president
            }
        }
    }
    
    

    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "navigationBarImage"), for: .default)
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "DRUNK PRESIDENTS"
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Collection View
    
    // Think about moving this to an extension
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.president_count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.president = President(rawValue: indexPath.row)
        let quoteVC = storyboard?.instantiateViewController(withIdentifier: "quoteVC") as! QuoteViewController
        quoteVC.president = self.president!
        navigationController?.pushViewController(quoteVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "presidentCell", for: indexPath) as! PresidentCell
        if indexPath.row >= self.president_count {
            cell.presidentNameLabel.text = "Coming soon"
            cell.presidentImageView.image = #imageLiteral(resourceName: "Coming soon portrait")
            return cell
        }
        self.president = President(rawValue: indexPath.row)
        
        // Think about moving this into a func
        switch self.president! {
        case .Washington:
            cell.presidentImageView.image = #imageLiteral(resourceName: "Washington Portrait")
            cell.presidentNameLabel.text = "George Washington"
        case .Lincoln:
            cell.presidentImageView.image = #imageLiteral(resourceName: "Lincoln Portrait")
            cell.presidentNameLabel.text = "Abraham Lincoln"
        case .FDR:
            cell.presidentImageView.image = #imageLiteral(resourceName: "FDR Portait")
            cell.presidentNameLabel.text = "Franklin D. Roosevelt"
        }
        return cell
    }
    
    // MARK: Utility
    
    func getPres (pres: Int) {
        
    }

}

