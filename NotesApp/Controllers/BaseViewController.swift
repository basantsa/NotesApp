//
//  BaseViewController.swift
//  NotesApp
//
//  Created by Basant Sarda on 04/04/18.
//  Copyright © 2018 Basant. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    let appTint = UIColor(red: 245/255.0, green: 182/255.0, blue: 111/255.0, alpha: 1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = appTint
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : appTint]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
