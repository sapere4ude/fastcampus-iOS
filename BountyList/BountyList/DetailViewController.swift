//
//  DetailViewController.swift
//  BountyList
//
//  Created by sapere4ude on 2020/12/01.
//

import UIKit

class DetailViewController: UIViewController {

    // MVVM
    
    // Model
    // - BountyInfo
    // > BountyInfo 만들기
    
    // View
    // > imgView, nameLabel, bountylabel
    // > View들은 ViewModel를 통해 구성됨
    
    // ViewModel
    // - DetailViewModel
    // > 뷰레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기. ex) BountyInfo 등
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    let viewModel = DetailViewModel() // viewModel을 통해 view와 viewController에 접근
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        
        guard let bountyInfo = self.viewModel.bountyInfo else {
            return
        }
        imgView.image = bountyInfo.image
        nameLabel.text = bountyInfo.name
        bountyLabel.text = "\(bountyInfo.bounty)"
        
    }

    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - ViewModel
class DetailViewModel {
    var bountyInfo: BountyInfo? // ViewModel이 Model을 소유하는 것
    
    func update(model: BountyInfo?) {
        bountyInfo = model
    }
}
