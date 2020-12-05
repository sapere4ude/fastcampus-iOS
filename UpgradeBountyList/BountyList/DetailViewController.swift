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
    
    @IBOutlet weak var nameLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var bountyLabelCentnerX: NSLayoutConstraint!
    
    let viewModel = DetailViewModel() // viewModel을 통해 view와 viewController에 접근
    
    // 메모리상에 올라가는 단계
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        prepareAnimation()
    }
    
    // 메모리에 올라간 이후 실제로 동작되는 상황
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimation()
    }
    
    private func prepareAnimation() {
        // Transform때문에 우선 주석처리
        //        nameLabelCenterX.constant = view.bounds.width
        //        bountyLabelCentnerX.constant = view.bounds.width
        
        nameLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        bountyLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        nameLabel.alpha = 0
        bountyLabel.alpha = 0
    }
    
    private func showAnimation() {
        // case 1. 직접 레이아웃을 건드릴때 사용하는 방식
        //        nameLabelCenterX.constant = 0
        //        bountyLabelCentnerX.constant = 0
        //
        //        UIView.animate(withDuration: 0.3,
        //                       delay: 0.1,
        //                       usingSpringWithDamping: 0.6,
        //                       initialSpringVelocity: 2,
        //                       options: .allowUserInteraction,
        //                       animations: {
        //                            self.view.layoutIfNeeded() // layout을 재정의하는 것. reloadData 느낌
        //        }, completion: nil)
        //
        //        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
        // case 2. view properties를 활용한 방식
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 2,
                       options: .allowUserInteraction,
                       animations: {
                        self.nameLabel.transform = CGAffineTransform.identity    // 원형의 모습을 알 수 있음
                        self.nameLabel.alpha = 1
                       }, completion: nil)
        
        UIView.animate(withDuration: 1,
                       delay: 0.2,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 2,
                       options: .allowUserInteraction,
                       animations: {
                        self.bountyLabel.transform = CGAffineTransform.identity
                        self.bountyLabel.alpha = 1
                       }, completion: nil)
        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
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
