//
//  NotesListViewController.swift
//  NotesApp
//
//  Created by Basant Sarda on 04/04/18.
//  Copyright © 2018 Basant. All rights reserved.
//

import UIKit
import CoreData

class NotesListViewController: BaseViewController, DataRequestHandlerDelegate {
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var totalNotesLabel:UILabel!
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataRequestHandler.sharedInstance.dataRequestHandlerDelegate = self
        notes = DataRequestHandler.sharedInstance.fetchAllNotes()
        self.updateTotalNotesLabel()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTotalNotesLabel() {
        if notes.count == 0 {
            totalNotesLabel.text = ""
        } else if notes.count == 1 {
            totalNotesLabel.text = "\(notes.count)" + " Note"
        } else {
            totalNotesLabel.text = "\(notes.count)" + " Notes"
        }
    }
    
    //MARK: - Action methods
    @IBAction func createNote() {
        self.performSegue(withIdentifier: "NotesDetailSegue", sender: self)
    }

    //MARK: - DataRequestHandlerDelegate
    func notesUpdated() {
        notes = DataRequestHandler.sharedInstance.fetchAllNotes()
        tableView.reloadData()
        self.updateTotalNotesLabel()
    }
}


extension NotesListViewController:UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as? NoteCell
        cell?.setUpCell(note: notes[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let noteDetailViewController = storyboard.instantiateViewController(withIdentifier: "NoteDetailViewController") as! NoteDetailViewController
        noteDetailViewController.note = notes[indexPath.row]
        self.navigationController?.pushViewController(noteDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            DataRequestHandler.sharedInstance.deleteNote(note:notes[indexPath.row])
        }
    }
}
