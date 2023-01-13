//
//  BookCell.swift
//  GoogleBookSearch
//
//  Created by Brendon Crowe on 1/12/23.
//

import UIKit

class BookCell: UITableViewCell {
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    

    func configureCell(for book: Book) {
        bookTitle.text = book.volumeInfo.title
        bookAuthor.text = book.volumeInfo.authors?.joined(separator: ", ")
        guard let imageUrlStr = book.volumeInfo.imageLinks?.smallThumbnail else {
            return
        }
        Image.getImage(from: imageUrlStr) { (result) in
            switch result {
            case .failure(let error):
                print("Error: \(error)")
            case .success(let image):
                DispatchQueue.main.async { [weak self] in
                    self?.bookImage.image = image
                }
            }
        }
    }
}
