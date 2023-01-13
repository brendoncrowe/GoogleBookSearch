//
//  ViewController.swift
//  GoogleBookSearch
//
//  Created by Brendon Crowe on 1/12/23.
//






/* TODO: Get the data from GOOGLE API
 
 */

import UIKit

class BookTableView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!


    var books = [Book]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet {
            loadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        
    }
    
    private func configVC() {
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    func loadData() {
        let api = "https://www.googleapis.com/books/v1/volumes?q=\(searchQuery)&maxResults=40"
        BookAPIClient.getBooks(from: api) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("Error: \(error)")
            case .success(let books):
                self?.books = books
            }
        }
    }
}

extension BookTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        let book = books[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = book.volumeInfo.title
        cell.contentConfiguration = content
        return cell
    }
}

extension BookTableView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchQuery = searchBar.text ?? ""
        searchBar.resignFirstResponder()
    }
}
