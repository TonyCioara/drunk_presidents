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
    @IBOutlet weak var titleLabel: UILabel!
    var president: President?
    var quote = "Server could not be accessed"
    
    @IBAction func cancelButton(_ sender: Any) {
    }
    @IBAction func refreshButton(_ sender: Any) {
        getNewQuote()
    }
    @IBAction func savebutton(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let president = president {
            switch president {
            case .FDR:
                titleLabel.text = "Franklin D. Roosevelt"
            case .Lincoln:
                titleLabel.text = "Abraham Lincoln"
            case .Washington:
                titleLabel.text = "George Washington"

            }
        }
        getNewQuote()
        print(self.quote)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNewQuote() {
        if let president = president {
            switch president {
            case .FDR:
                Network.instance.fetch(route: Route.get_FDR) { (data) in
                    if let jsonQuote = try? JSONDecoder().decode(Sentence.self, from: data) {
                        print(jsonQuote)
                        self.quote = jsonQuote.sentence
                    }
                }
            case .Lincoln:
                Network.instance.fetch(route: Route.get_Lincoln) { (data) in
                    if let jsonQuote = try? JSONDecoder().decode(Sentence.self, from: data) {
                        print(jsonQuote)
                        self.quote = jsonQuote.sentence
                    }
                }
            case .Washington:
                Network.instance.fetch(route: Route.get_Washington) { (data) in
                    if let jsonQuote = try? JSONDecoder().decode(Sentence.self, from: data) {
                        print(jsonQuote)
                        self.quote = jsonQuote.sentence
                    }
                }
            }
        }
        self.quoteLabel.text = self.quote
    }
}
