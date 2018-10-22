//
//  AddContactViewController.swift
//  Task3
//
//  Created by Tester on 10/22/18.
//  Copyright © 2018 aaa. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    var dataIsComplete: Bool!
    
    var networkController: NetworkController!
    var picker: UIImagePickerController = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddImageButtonTapped(_ sender: Any) {
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    
    @IBAction func doneButtonDidTap(_ sender: UIButton) {
        var data = [String : Any]()
        dataIsComplete = true
        
        if let firstName = stringFromTextField(firstNameTextField) {
            data["firstName"] = firstName
        }
        
        if let lastName = stringFromTextField(lastNameTextField) {
            data["lastName"] = lastName
        }
        
        if let phone = stringFromTextField(phoneTextField) {
            data["phone"] = phone
        }
        
        if let email = stringFromTextField(emailTextField) {
            data["email"] = email
        }
        
        if let notes = stringFromTextField(notesTextField) {
            data["notes"] = notes
        }
        
        if dataIsComplete {
            networkController.addContact(withData: data, image: avatarImageView.image) { error in
                if error == nil {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    private func trimEndWhiteSpace (string: String) -> String {
        return string.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
    }
    
    private func stringFromTextField(_ textField: UITextField) -> String? {
        if let value = textField.text {
            if !value.isEmpty {
                return trimEndWhiteSpace(string: value)
            } else {
                dataIsComplete = false
                textField.textColor = UIColor.red
                textField.text = "Required field"
            }
        } else {
            dataIsComplete = false
        }
        
        return nil
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

//Text Field Delegate
extension AddContactViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.textColor == UIColor.red {
            textField.text = ""
            textField.textColor = UIColor.black
        }
        return true
    }
}

extension AddContactViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        avatarImageView.image = chosenImage
        addImageButton.setTitle("Change", for: .normal)
        dismiss(animated: true)
    }
}
