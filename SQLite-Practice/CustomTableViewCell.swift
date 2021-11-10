//
//  CustomTableViewCell.swift
//  SQLite-Practice
//
//  Created by 大西玲音 on 2021/11/11.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    func configure(user: User) {
        nameLabel.text = user.name
        emailLabel.text = user.email
    }

}
