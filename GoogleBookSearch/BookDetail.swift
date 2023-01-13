//
//  BookDetailViewController.swift
//  GoogleBookSearch
//
//  Created by Brendon Crowe on 1/12/23.
//

import UIKit

class BookDetail: UIViewController {
    
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthors: UILabel!
    @IBOutlet weak var bookDescription: UITextView!
    
    var book: Book?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let imageString = book?.volumeInfo.imageLinks?.thumbnail else {
            return
        }
        Image.getImage(from: imageString) { (result) in
            switch result {
            case .failure(let error):
                print("Error: \(error)")
            case .success(let image):
                DispatchQueue.main.async { [weak self] in
                    self?.bookImage.image = image
                }
            }
        }
        bookTitle.text = book?.volumeInfo.title
        bookAuthors.text = book?.volumeInfo.authors?.joined(separator: ", ")
        bookDescription.text = book?.volumeInfo.description
    }
    
    
    
}
