//
//  ViewController.swift
//  MUSample
//
//  Created by Damien Noël Dubuisson on 21/02/2019.
//  Copyright © 2019 Damien Noël Dubuisson. All rights reserved.
//

import UIKit

class Main: UITableViewController {
    private var datas = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = type(of: self).description().components(separatedBy: ".").last

        guard let urls = Bundle.main.urls(forResourcesWithExtension: "storyboardc", subdirectory: nil) else {
            return
        }

        datas = urls.map({ $0.deletingPathExtension().lastPathComponent })
            .filter({ $0 != "Main" && $0 != "LaunchScreen" })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = datas[indexPath.row]
        cell.textLabel?.textColor = .black
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: datas[indexPath.row], bundle: nil).instantiateInitialViewController() {
            show(vc, sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
