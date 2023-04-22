//
//  NoteViewController.swift
//  Final_Project_Notes_App
//
//  Created by Anastasia Neagu on 13.04.2023.
//

import UIKit

class NoteViewController: UIViewController {
    
    public var noteTitle: String = ""
    public var noteText: String = ""
    var noteTitleLabel = UILabel()
    var noteTextLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        noteTitleLabel.text = noteTitle
        view.addSubview(noteTitleLabel)
        
        noteTextLabel.translatesAutoresizingMaskIntoConstraints = false
        noteTextLabel.text = noteText
        view.addSubview(noteTextLabel)
        
        let constraints = [
            noteTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            noteTitleLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10.0),
            noteTitleLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10.0),
            noteTitleLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1),
            noteTextLabel.topAnchor.constraint(equalTo: noteTitleLabel.bottomAnchor, constant: 10.0),
            noteTextLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10.0),
            noteTextLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10.0),
            noteTextLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        // Do any additional setup after loading the view.
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
