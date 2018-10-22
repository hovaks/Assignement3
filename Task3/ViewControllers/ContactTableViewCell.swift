//
//  ContactTableViewCell.swift
//  Task3
//
//  Created by Tester on 10/22/18.
//  Copyright © 2018 aaa. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    var contact: Contact! {
        didSet {
            setup(with: contact)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setup(with contact: Contact) {
        
//        var baseURLString = "http://142.93.143.76"
//        baseURLString += "/images/\(product.image)"
//        guard let url = URL(string: baseURLString) else { return }
//        productImageView.kf.indicatorType = .activity
//        productImageView.kf.setImage(with: url)
        firstNameLabel.text = contact.firstName
        lastNameLabel.text = contact.lastName
        phoneLabel.text = contact.phone
        emailLabel.text = contact.email
        if let notes = contact.notes {
            notesLabel.text = contact.notes
        } else {
            notesLabel.text = " "
        }
    }

}
