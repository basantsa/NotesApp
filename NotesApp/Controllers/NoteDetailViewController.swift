//
//  NoteDetailViewController.swift
//  NotesApp
//
//  Created by Basant Sarda on 04/04/18.
//  Copyright © 2018 Basant. All rights reserved.
//

import UIKit

class NoteDetailViewController: BaseViewController, UITextViewDelegate {

    @IBOutlet weak var textView:UITextView!
    @IBOutlet weak var bottomContraint:NSLayoutConstraint!
    
    var note:Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(NoteDetailViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NoteDetailViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        if let note = note {
            textView.text = note.noteText
        }
        
        textView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if textView.text != "" {
            if let note = note {
                note.noteText = textView.text
                DataRequestHandler.sharedInstance.save()
            } else {
                DataRequestHandler.sharedInstance.createNewNote(noteStr: textView.text)
            }
        } else {
            //check for condition when the user deletes all the text of already created note.
            if let note = note {
                DataRequestHandler.sharedInstance.deleteNote(note: note)
            }
        }
        super.viewWillDisappear(true)
    }

    //MARK: - Keyboard notification.
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize.height)
                bottomContraint.constant = keyboardSize.height
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(keyboardSize.height)
            bottomContraint.constant = 5
        }
    }
    
    //MARK: - UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text.count + (text.count - range.length) <= 300 {
            return true
        } else {
            let alertController = UIAlertController(title: "Error",
                                                    message: "Maximum 300 characters allowed.",
                                                    preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return false
        }
    }

}
