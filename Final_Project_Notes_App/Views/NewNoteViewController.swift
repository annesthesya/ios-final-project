//
//  NewNoteViewController.swift
//  Final_Project_Notes_App
//
//  Created by Anastasia Neagu on 13.04.2023.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    var noteTitle = ""
    var noteText = ""
    var noteTitleField = UITextView()
    var noteTextField = UITextView()
    
    public var completion : ((String, String) -> Void)?
    
    @objc @IBAction func rightBarButtonItemTapped() {
        if let text = noteTextField.text, !text.isEmpty{
            completion!(noteTitleField.text!, noteTextField.text!)
        }
        else if let text = noteTitleField.text, !text.isEmpty{
            let alert = UIAlertController(title: "Empty note body!", message: "Please add text to the note body or move the title text to the body.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)        }
    }

    @objc @IBAction func leftBarButtonItemTapped() {
        
        if noteText != noteTextField.text! || noteTitle != noteTitleField.text! {
                let alert = UIAlertController(title: "Unsaved Changes", message: "You have unsaved changes. Do you want to keep editing or discard them?", preferredStyle: .actionSheet)
                
                let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
                    self.rightBarButtonItemTapped()
                }
            
                let discardAction = UIAlertAction(title: "Discard Changes", style: .destructive) { (action) in
                    self.navigationController?.popViewController(animated: true)
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
                alert.addAction(saveAction)
                alert.addAction(discardAction)
                alert.addAction(cancelAction)
                
                present(alert, animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.leftBarButtonItemTapped))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(NewNoteViewController.rightBarButtonItemTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(ViewController.leftBarButtonItemTapped))
        
        view.backgroundColor = .darkGray
        
        noteTitleField.translatesAutoresizingMaskIntoConstraints = false
        noteTitleField.backgroundColor = .gray
        noteTitleField.textAlignment = .center
        noteTitleField.font = UIFont.boldSystemFont(ofSize: 20.0)
        noteTitleField.text = noteTitle
        noteTitleField.textContainer.maximumNumberOfLines = 3
        noteTitleField.clipsToBounds = true
        noteTitleField.layer.cornerRadius = 10.0
        view.addSubview(noteTitleField)
        
        noteTextField.translatesAutoresizingMaskIntoConstraints = false
        noteTextField.backgroundColor = .gray
        noteTextField.becomeFirstResponder()
        noteTextField.font = UIFont.systemFont(ofSize: 18.0)
        noteTextField.text = noteText
        noteTextField.clipsToBounds = true
        noteTextField.layer.cornerRadius = 10.0
        view.addSubview(noteTextField)
        
        let constraints = [
            noteTitleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            noteTitleField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10.0),
            noteTitleField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10.0),
            noteTitleField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.1),
            noteTextField.topAnchor.constraint(equalTo: noteTitleField.bottomAnchor, constant: 10.0),
            noteTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10.0),
            noteTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10.0),
            noteTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
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
