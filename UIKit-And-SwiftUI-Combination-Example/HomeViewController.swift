//
//  HomeViewController.swift
//  UIKit-And-SwiftUI-Combination-Example
//
//  Created by Sparkout on 07/09/23.
//

import UIKit
import Combine
import SwiftUI

class HomeViewController: UIViewController {
    
    let userData = UserNameListViewModel(users: ["Shan", "VK", "AK", "VP"])
    var cancellable: Set<AnyCancellable> = .init()
    
    @IBOutlet weak var usersListView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUsersList()
    }
    
    func configureUsersList() {
        
        // Embed SwiftUI into UIView
        let contentView = UserNameListContentView(usersVM: userData)
        let usersList = UIHostingController(rootView: contentView)
        usersListView.embed(childViewController: usersList)
        
        // Listening Updates
        userData.$updatedUserList.sink { value in
            print(value)
        }
        .store(in: &cancellable)
    }

    @IBAction func submitActionTapped(_ sender: Any) {
        // userData.users.append("Submit")
        let vc: UIViewController = .init()
        vc.view.backgroundColor = .orange
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = .blue
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Index \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userData.users.append("Index \(indexPath.row)")
    }
}

