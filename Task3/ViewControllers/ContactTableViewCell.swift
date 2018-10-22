//
//  ContactTableViewCell.swift
//  Task3
//
//  Created by Tester on 10/22/18.
//  Copyright © 2018 aaa. All rights reserved.
//

import UIKit
import Kingfisher

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
        
        if let imageID = contact.images?.first {
        let baseURLString = "https://stdevtask3-0510.restdb.io/media/" + "\(imageID)"
            let url = URL(string: baseURLString)
            let size = CGSize(width: avatarImageView.bounds.size.width,
                              height: avatarImageView.bounds.size.height)
            let p = ResizingImageProcessor(referenceSize: size, mode: .aspectFit)
            avatarImageView.kf.setImage(with: url, options: [.processor(p)])
        }
        
        firstNameLabel.text = contact.firstName
        lastNameLabel.text = contact.lastName
        phoneLabel.text = contact.phone
        emailLabel.text = contact.email
        if let notes = contact.notes {
            notesLabel.text = notes
        } else {
            notesLabel.text = " "
        }
    }

}
