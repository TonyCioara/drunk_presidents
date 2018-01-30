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
    var quote = "Waiting for server ..."
    
    @IBAction func cancelButton(_ sender: Any) {
    }
    @IBAction func refreshButton(_ sender: Any) {
        getNewQuote() {
            self.quoteLabel.text = self.quote
        }
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
        getNewQuote() {
            self.quoteLabel.text = self.quote
        }
        print(self.quote)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
