//
//  DetailViewController.swift
//  BountyList
//
//  Created by sapere4ude on 2020/12/01.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    // BountyViewController에서 데이터를 가져오기 위해서 반드시 필요한 프로퍼티
    var name: String?
    var bounty: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        
        guard let name = self.name, let bounty = self.bounty else {
            return
        }
        let img = UIImage(named: "\(name).jpg")
        imgView.image = img
        nameLabel.text = name
        bountyLabel.text = "\(bounty)"
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
