//
//  ViewController.swift
//  drunk_presidents_frontend
//
//  Created by Tony Cioara on 1/17/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit
enum President: Int {
    case Washington = 0
    case Lincoln = 1
    case FDR = 2
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let president_count = 4
    var president: President?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toQuote" {
                let quoteViewController = segue.destination as! QuoteViewController
                quoteViewController.president = self.president
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        if indexPath.row == self.president_count - 1 {
            cell.presidentNameLabel.text = "Coming soon"
            return cell
        }
        self.president = President(rawValue: indexPath.row)
        switch self.president! {
        case .Washington:
            cell.presidentImageView.image = #imageLiteral(resourceName: "george-washington-in-black-and-white")
            cell.presidentNameLabel.text = "George Washington"
        case .Lincoln:
            cell.presidentImageView.image = #imageLiteral(resourceName: "Abraham_Lincoln_O-77_matte_collodion_print")
            cell.presidentNameLabel.text = "Abraham Lincoln"
        case .FDR:
            cell.presidentImageView.image = #imageLiteral(resourceName: "FDR_in_1933")
            cell.presidentNameLabel.text = "Franklin D. Roosevelt"
        }
        return cell
    }

}

