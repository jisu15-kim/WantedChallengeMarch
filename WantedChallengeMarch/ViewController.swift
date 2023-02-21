//
//  ViewController.swift
//  WantedChallengeMarch
//
//  Created by 김지수 on 2023/02/21.
//

import UIKit

class ViewController: UIViewController {
    var images: [String] = []
    
    @IBOutlet weak var loadAllBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        images = ImageUrl.urls
        setupUI()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 130
        tableView.allowsSelection = false
    }
    
    private func setupUI() {
        loadAllBtn.layer.cornerRadius = 15
        loadAllBtn.clipsToBounds = true
    }
    
    @IBAction func loadAllBtnTapped(_ sender: UIButton) {
        
        images.enumerated().forEach { (index, image) in
            guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? DemoCell else { return }
            cell.configure()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DemoCell", for: indexPath) as? DemoCell else { return UITableViewCell() }
        cell.image = images[indexPath.row]
        cell.configure()
        return cell
    }
}
