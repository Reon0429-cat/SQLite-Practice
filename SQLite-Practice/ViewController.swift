//
//  ViewController.swift
//  SQLite-Practice
//
//  Created by 大西玲音 on 2021/11/10.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let database = Database()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.nib,
                           forCellReuseIdentifier: CustomTableViewCell.identifier)
        
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        database.userDataStore.find().count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.identifier
        ) as! CustomTableViewCell
        let user = database.userDataStore.find()[indexPath.row]
        cell.configure(user: user)
        return cell
    }
    
}
