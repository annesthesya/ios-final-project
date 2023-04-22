//
//  NewTableViewCell.swift
//  Final_Project_Notes_App
//
//  Created by Anastasia Neagu on 20.04.2023.
//

import UIKit

class NewTableViewCell: UITableViewCell {

    // MARK: - Static
    static let newTableViewCellReuseIdentifier = "newTableViewCellReuseIdentifier"
    static var rootTableViewCellCount = 0

    // MARK: - IVars

    let noteTitleLabel = UILabel()
    let noteTextLabel = UILabel()
    let lastEditLabel = UILabel()
    let dateFormatter = DateFormatter()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .gray
        
        noteTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        noteTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        contentView.addSubview(noteTitleLabel)
        
        noteTextLabel.translatesAutoresizingMaskIntoConstraints = false
        noteTextLabel.font = UIFont.systemFont(ofSize: 14.0)
        noteTextLabel.textColor = .darkGray
        noteTextLabel.numberOfLines = 1
        contentView.addSubview(noteTextLabel)

        lastEditLabel.translatesAutoresizingMaskIntoConstraints = false
        lastEditLabel.font = UIFont.boldSystemFont(ofSize: 10)
        lastEditLabel.textColor = .lightGray
        lastEditLabel.numberOfLines = 2
        contentView.addSubview(lastEditLabel)
        
        let constraints = [
            noteTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            noteTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0),
            noteTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50.0),
            noteTextLabel.leadingAnchor.constraint(equalTo: noteTitleLabel.leadingAnchor),
            noteTextLabel.topAnchor.constraint(equalTo: noteTitleLabel.bottomAnchor, constant: 5.0),
            noteTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25.0),
            lastEditLabel.topAnchor.constraint(equalTo: noteTextLabel.bottomAnchor, constant: 5.0),
            lastEditLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0),
            ]
        NSLayoutConstraint.activate(constraints)
    }
    required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
    deinit {
    }

    func setup(note: AppNote) {
            noteTitleLabel.text = note.title!
            noteTextLabel.text = note.text!
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .short
            let editDate = dateFormatter.string(from: note.lastEdit!)
            lastEditLabel.text = "Last edited \(editDate)"
        }
    
}
