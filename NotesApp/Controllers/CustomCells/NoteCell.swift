//
//  NoteCell.swift
//  NotesApp
//
//  Created by Basant Sarda on 04/04/18.
//  Copyright © 2018 Basant. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    @IBOutlet weak var noteTextField:UILabel!
    @IBOutlet weak var noteDateLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(note:Note) {
        noteTextField.text = note.noteText
        noteDateLabel.text = NSDate.stringForDisplay(from: note.noteCreationDate!, prefixed: false, alwaysDisplayTime: true)
    }

}
