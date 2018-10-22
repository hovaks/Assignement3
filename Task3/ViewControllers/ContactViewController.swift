//
//  ContactViewController.swift
//  Task3
//
//  Created by Tester on 10/22/18.
//  Copyright © 2018 aaa. All rights reserved.
//

import UIKit
import Kingfisher

class ContactViewController: UIViewController {
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var notesLabel: UILabel!
    
    var contact: Contact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(with: contact)
        // Do any additional setup after loading the view.
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
        
        nameLabel.text = contact.firstName + " " + contact.lastName
        phoneButton.setTitle(contact.phone, for: .normal)
        emailButton.setTitle(contact.email, for: .normal)
        
        if let notes = contact.notes {
            notesLabel.text = notes
        } else {
            notesLabel.text = " "
        }
    }
    
    @IBAction func phoneButtonTapped(_ sender: UIButton) {
        guard
            let numberString = sender.title(for: .normal),
            let number = URL(string: "tel://" + numberString)
            else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        guard
            let emailString = sender.title(for: .normal),
            let email = URL(string: "mailto://" + emailString)
            else { return }
        UIApplication.shared.open(email)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
