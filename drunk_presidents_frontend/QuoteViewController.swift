//
//  QuoteViewController.swift
//  drunk_presidents_frontend
//
//  Created by Tony Cioara on 1/20/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit
import CoreData

struct Sentence: Codable {
    var sentence: String
}

class QuoteViewController: UIViewController {
    let coreDataStack = CoreDataStack.instance
    
    @IBOutlet weak var presidentImageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    var president: President?
    var quote = "Getting drunk ..."
    
    
    @IBAction func saveButton(_ sender: Any) {
        guard let presidentName = self.navigationItem.title else {return}
        let saveQuote = Quote(context: coreDataStack.privateContext)
        saveQuote.president = presidentName
        saveQuote.quote = self.quote
        print(saveQuote)
        coreDataStack.saveTo(context: coreDataStack.privateContext)
        
//        Notify user that item was saved
        let alert = UIAlertController(title: "Saved", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        getNewQuote() {
            self.quoteLabel.text = self.quote
        }
    }
    @IBAction func bookmarksButton(_ sender: Any) {
        let bookmarksVC = storyboard?.instantiateViewController(withIdentifier: "bookmarksVC") as! BookmarksViewController
        navigationController?.pushViewController(bookmarksVC, animated: true)
    }
    
    // MARK: View Lifecycle
    
    // Add some comments divide and group code by functionality...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.topItem!.title = ""
        if let president = self.president {
            switch president {
            case .FDR:
                self.navigationItem.title = "Franklin D. Roosevelt"
                self.presidentImageView.image = #imageLiteral(resourceName: "FDR Portait")
            case .Lincoln:
                self.navigationItem.title = "Abraham Lincoln"
                self.presidentImageView.image = #imageLiteral(resourceName: "Lincoln Portrait")
            case .Washington:
                self.navigationItem.title = "George Washington"
                self.presidentImageView.image = #imageLiteral(resourceName: "Washington Portrait")
            }
        }
        getNewQuote() {
            self.quoteLabel.text = self.quote
        }
        print(self.quote)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // TODO: This could more DRY... Put it in the "dryer"
    
    func getNewQuote(completion: @escaping ()->()) {
        if let president = president {
            switch president {
            case .FDR:
                Network.instance.fetch(route: Route.get_FDR) { (data) in
                    self.updateSentece(data: data)
                }
            case .Lincoln:
                Network.instance.fetch(route: Route.get_Lincoln) { (data) in
                    self.updateSentece(data: data)
                }
            case .Washington:
                Network.instance.fetch(route: Route.get_Washington) { (data) in
                    self.updateSentece(data: data)
                }
            }
        }
        completion()
    }
    
    func updateSentece(data: Data) {
        DispatchQueue.main.async {
            if let jsonQuote = try? JSONDecoder().decode(Sentence.self, from: data) {
                print(jsonQuote)
                self.quote = jsonQuote.sentence
                self.quoteLabel.text = self.quote
            }
        }
    }
}
