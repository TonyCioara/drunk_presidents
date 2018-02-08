//
//  QuoteViewController.swift
//  drunk_presidents_frontend
//
//  Created by Tony Cioara on 1/20/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit

struct Sentence: Codable {
    var sentence: String
}

class QuoteViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    var president: President?
    var quote = "Getting drunk ..."
    
    @IBAction func refreshButton(_ sender: Any) {
        getNewQuote() {
            self.quoteLabel.text = self.quote
        }
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
            case .Lincoln:
                self.navigationItem.title = "Abraham Lincoln"
            case .Washington:
                self.navigationItem.title = "George Washington"
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
                    DispatchQueue.main.async {
                        if let jsonQuote = try? JSONDecoder().decode(Sentence.self, from: data) {
                            print(jsonQuote)
                            self.quote = jsonQuote.sentence
                            self.quoteLabel.text = self.quote
                        }
                    }
                }
            case .Lincoln:
                Network.instance.fetch(route: Route.get_Lincoln) { (data) in
                    DispatchQueue.main.async {
                        if let jsonQuote = try? JSONDecoder().decode(Sentence.self, from: data) {
                            print(jsonQuote)
                            self.quote = jsonQuote.sentence
                            self.quoteLabel.text = self.quote
                        }
                    }
                }
            case .Washington:
                Network.instance.fetch(route: Route.get_Washington) { (data) in
                    DispatchQueue.main.async {
                        if let jsonQuote = try? JSONDecoder().decode(Sentence.self, from: data) {
                            print(jsonQuote)
                            self.quote = jsonQuote.sentence
                            self.quoteLabel.text = self.quote
                        }
                    }
                }
            }
        }
        completion()
        
    }
}
