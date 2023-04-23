//
//  ViewController.swift
//  Final_Project_Notes_App
//
//  Created by Anastasia Neagu on 13.04.2023.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    let number = RootTableViewCell.rootTableViewCellCount
//    let launch = UserDefaults.standard.integer(forKey: AppDelegate.Constants.appLaunchCountUserDefaultsKey)
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var label: UILabel!
    
    var notes : [AppNote] = []
    
//    var models : [(title: String, note : String)] = []
    
    @objc @IBAction func leftBarButtonItemTapped() {
//        let alert = UIAlertController(title: "Cell Count", message: "The number of cells is \(number).", preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        alert.addAction(cancelAction)
//        present(alert, animated: true)
    }
    
    @objc @IBAction func rightBarButtonItemTapped() {
        let newNoteViewController = NewNoteViewController()
        navigationController?.pushViewController(newNoteViewController, animated: true)
        navigationItem.largeTitleDisplayMode = .never
        newNoteViewController.completion = {noteTitle, noteText in
            let note = CoreDataManager.shared.createNote()
            if noteTitle.isEmpty {
                CoreDataManager.shared.updateNote(note: note, title: "Note \(self.notes.count + 1)", text: noteText)
            }
            else {
                CoreDataManager.shared.updateNote(note: note, title: noteTitle, text: noteText)
            }
            self.notes.insert(note, at: 0)
            self.navigationController?.popToRootViewController(animated: true)
            self.tableView.reloadData()
            self.label.isHidden = true
            self.tableView.isHidden = false
            let alert = UIAlertController(title: "Success", message: "Your new note has been saved!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel)
            alert.addAction(cancelAction)
            self.present(alert, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let note = notes[indexPath.row]
        
        guard let newNoteViewController = storyboard?.instantiateViewController(withIdentifier: "new") as? NewNoteViewController else {
            return
        }
        newNoteViewController.title = "Note"
        newNoteViewController.noteTitle = note.title!
        newNoteViewController.noteText = note.text!
        navigationController?.pushViewController(newNoteViewController, animated: true)
        newNoteViewController.completion = {noteTitle, noteText in
            if noteTitle != note.title || noteText != note.text {
                if noteTitle.isEmpty {
                    CoreDataManager.shared.updateNote(note: note, title: "Note \(self.notes.count + 1)", text: noteText)
                }
                else {
                    CoreDataManager.shared.updateNote(note: note, title: noteTitle, text: noteText)
                }
                self.navigationController?.popToRootViewController(animated: true)
                self.notes = CoreDataManager.shared.fetchNotes()
                self.tableView.reloadData()
                self.label.isHidden = true
                self.tableView.isHidden = false
                let alert = UIAlertController(title: "Success", message: "Your note has been updated!", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Dismiss", style: .cancel)
                alert.addAction(cancelAction)
                self.present(alert, animated: true)
            }
            else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let note = notes[indexPath.row]
                CoreDataManager.shared.deleteNote(note: note)
                notes = CoreDataManager.shared.fetchNotes()
                tableView.reloadData()
            }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewTableViewCell.newTableViewCellReuseIdentifier, for: indexPath) as? NewTableViewCell {
            let note = notes[indexPath.row]
            cell.setup(note: note)
            return cell
        }
        else{
            return UITableViewCell()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authButton = createAuthButton()
        view.addSubview(authButton)
    }
    
    func createLayout() {
        notes = CoreDataManager.shared.fetchNotes()
        
        title = "My Notes"
        view.backgroundColor = .darkGray
        
        label.text = "No notes yet!"
        label.textAlignment = .center
        if notes.count != 0 {
            navigationItem.largeTitleDisplayMode = .never
            label.isHidden = true
        }
        view.addSubview(label)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Note", style: .done, target: self, action: #selector(ViewController.rightBarButtonItemTapped))
        
        tableView.dataSource = self
        tableView.delegate = self
        if notes.count != 0 {
            tableView.isHidden = false
        }
        tableView.backgroundColor = .darkGray
        tableView.register(NewTableViewCell.self, forCellReuseIdentifier: NewTableViewCell.newTableViewCellReuseIdentifier)
        tableView.rowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func createAuthButton()  -> UIButton {
        let authButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50));
        authButton.center = view.center;
        authButton.setTitle("Authorize", for: .normal);
        authButton.backgroundColor = .systemGray;
        authButton.addTarget(self, action: #selector(didTapAuthButton), for: .touchUpInside);
        return authButton
    }

    @objc func didTapAuthButton() {
        let context = LAContext()
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authorize with Touch ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason,
                                   reply: {[weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        let alert = UIAlertController(title: "Failed to Authenticate", message: "Please try again", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
                        self?.present(alert, animated: true)
                        return;
                    }
                    //show screen
                    //success
                    self?.createLayout()
                }
            })
        } else {
            // can not use
            let alert = UIAlertController(title: "Unavailable", message: "You cant use this feature", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
        }
    }

}

