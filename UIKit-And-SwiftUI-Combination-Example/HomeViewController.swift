//
//  HomeViewController.swift
//  UIKit-And-SwiftUI-Combination-Example
//
//  Created by Sparkout on 07/09/23.
//

import UIKit
import Combine
import SwiftUI
/*
#if DEBUG
struct UserNameListContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserNameListContentView()
            .previewLayout(.fixed(width: 200, height: 100))
    }
}
#endif
 */

class UserNameListViewModel: ObservableObject {
    @Published var users: [String]
    @Published var updatedUserList: [String] = []
    init(users: [String]) {
        self.users = users
    }
}

struct UserNameListContentView: View {
    @ObservedObject var usersVM: UserNameListViewModel
    
    var body: some View {
        VStack {
            VStack {
                ForEach(usersVM.users, id: \.self) { name in
                    Text("\(name).dev")
                }
            }
            Divider()
            Text("Success")
            Button {
                usersVM.updatedUserList = ["Shan.1", "VK.1", "AR.1", "PV.1"]
            } label: {
                Text("Submit")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
        .padding(12)
        .background(Color.green)
    }
}

class HomeViewController: UIViewController {
    let userData = UserNameListViewModel(users: ["Shan", "VK", "AR", "PV"])
    var cancellable: Set<AnyCancellable> = .init()
    @IBAction func submitActionTapped(_ sender: Any) {
        userData.users.append("s")
    }
    @IBOutlet weak var usersListView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUsersList()
    }
    
    func configureUsersList() {
        userData.$updatedUserList.sink { value in
            print(value)
        }
        .store(in: &cancellable)
        let contentView = UserNameListContentView(usersVM: userData)
        let usersList = UIHostingController(rootView: contentView)
        usersListView.embed(childViewController: usersList)
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
}

// MARK: - Insert constrained subview
extension UIView {
    func embed(childViewController: UIViewController) {
        self.addSubview(childViewController.view)
        constrainViewEqual(holderView: self, view: childViewController.view)
    }
    
    func constrainViewEqual(holderView: UIView, view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: holderView, attribute: .top, multiplier: 1.0, constant: 0)
        let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
        let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)
        
        holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
    }
    
    func addConstrainedSubview(subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func addConstrainedSubviewToSafeAreas(subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
