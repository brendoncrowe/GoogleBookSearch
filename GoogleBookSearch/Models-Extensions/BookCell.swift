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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateUI(for book: Book) {
        
    }

}
