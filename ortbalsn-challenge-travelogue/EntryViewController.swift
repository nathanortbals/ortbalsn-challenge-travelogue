//
//  EntryViewController.swift
//  ortbalsn-challenge-travelogue
//
//  Created by Nathan Ortbals on 4/9/19.
//  Copyright © 2019 nathanortbals. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    var trip: Trip!
    var existingEntry: Entry!
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextArea: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = existingEntry?.title
        contentTextArea.text = existingEntry?.contant
        imageView.image = existingEntry?.image
    }
    
    @IBAction func openCamera(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera not supported by this device")
            return
        }
        
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
    
    @IBAction func openPhotoLibrary(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("can't open photo library")
            return
        }
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        let title = titleTextField.text
        let content = contentTextArea.text
        let image = imageView.image
        
        var entry: Entry?
        if let existingEntry = existingEntry {
            existingEntry.title = title
            existingEntry.contant = content
            existingEntry.image = image
            
            entry = existingEntry
        }
        else {
            entry = Entry(title: title, content: content, image: image)
            trip?.addToRawEntries(entry!)
        }
        
        if let entry = entry{
            do {
                let managedContext = entry.managedObjectContext
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            } catch{
                print("Entry not saved")
            }
        }
    }

}

extension EntryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        defer {
            picker.dismiss(animated: true)
        }
        
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        imageView.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer {
            picker.dismiss(animated: true)
        }
        
        print("did cancel")
    }
}
