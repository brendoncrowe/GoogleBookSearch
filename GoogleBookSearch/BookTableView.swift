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
    
    // MARK: It is outside the scope of this app to have deeper search functionality allowing for more filtered searches
    // This app will search for volumes that contain the text string that the user input.
    
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
        tableView.delegate = self
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookCell else {
            fatalError("could not dequeue BookCell ")
        }
        let book = books[indexPath.row]
        cell.configureCell(for: book)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? BookDetail, let indexPath = tableView.indexPathForSelectedRow else {
            print("Error with loading Book Detail controller")
            return
        }
        dvc.book = books[indexPath.row]
    }
}

extension BookTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension BookTableView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard !searchBar.text!.isEmpty else {
            searchBar.resignFirstResponder()
            print("No text in search bar")
            return
        }
        
        // MARK: the string method replacingOccurrences() is VERY important for user experience. The api understands _ as a space, but the user shouldn't have to use _ instead of a "space". Using this method replaces spaces inputted by the user with _
        
        searchQuery = searchBar.text!.replacingOccurrences(of: " ", with: "_")
        searchBar.resignFirstResponder()
        print(searchQuery)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            books.removeAll()
            return
        }
    }
}
