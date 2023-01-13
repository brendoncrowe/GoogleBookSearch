//
//  ViewController.swift
//  GoogleBookSearch
//
//  Created by Brendon Crowe on 1/12/23.
//

import UIKit

class BookTableView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var books = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
    }
    

}

extension BookTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        return cell
    }
    
}


struct PropertyKey {
//    var api = "https://www.googleapis.com/books/v1/volumes?q=\(searchTerm)&maxResults=40"
}
