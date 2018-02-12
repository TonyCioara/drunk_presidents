//
//  BookmarksViewController.swift
//  drunk_presidents_frontend
//
//  Created by Tony Cioara on 2/10/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import UIKit
import CoreData

class BookmarksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let stack = CoreDataStack.instance
    var quotes = [Quote]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetch = NSFetchRequest<Quote>(entityName: "Quote")
        do {
            let result = try stack.viewContext.fetch(fetch)
            self.quotes = result
            self.tableView.reloadData()
            
        }catch let error {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as! QuoteCell
        let row = indexPath.row
        let presidentName = quotes[row].president!
        let quote = quotes[row].quote!
        cell.quoteLabel.text = presidentName + ": " + quote
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deleteQuote = self.quotes[indexPath.row]
            stack.viewContext.delete(deleteQuote)
            stack.saveTo(context: stack.viewContext)
            self.quotes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
