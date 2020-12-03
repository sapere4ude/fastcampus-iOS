//
//  ViewController.swift
//  BountyList
//
//  Created by sapere4ude on 2020/12/01.
//

import UIKit

class BountyViewController: UIViewController {

    // MVVM
    
    // Model
    // - BountyInfo
    // > BountyInfo 만들기
    
    // View
    // - ListCell
    // > ListCell을 만들기 위해 필요한 정보를 ViewModel한테서 받아야겠다.
    // > ListCell은 ViewModel로부터 받은 정보로 뷰 업데이트하기
    
    // ViewModel
    // - BountyViewModel
    // > BountyViewModel을 만들고 뷰레이어에서 필요한 메서드 만들기
    // > 모델 가지고 있기. ex) BountyInfo 등
    
    
    let viewModel = bountyViewModel()   // MVVM 패턴은 Model에서 정의한 것을 View가 직접 가져갈 수 없기떄문에 중간에 View Model을 생성해줘야 한다
    
    // Segue를 호출하기 직전에 준비해주는 것. DetailViewController에게 데이터를 주는 것
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            
            if let index = sender as? Int {  // Any로 받았던 것을 Int로 다운캐스팅

                let bountyInfo = viewModel.bountyInfo(at: index)

                vc?.viewModel.update(model: bountyInfo)

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// 프로토콜을 사용하기 위해서는
extension BountyViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDataSource. 몇개를 보여줄까?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfBoutnyInfoList
    }
    
    // UICollectionViewDataSource. 셀은 어떻게 표현할까?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else {
            return UICollectionViewCell()
        }
    
        let bountyInfo = viewModel.bountyInfo(at: indexPath.item)
        cell.update(info: bountyInfo)
        return cell
    }
    
    // UICollectionViewDelegate. 셀이 클릭되었을땐??
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("--> \(indexPath.item)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    // UICollectionViewDelegateFlowLayout. 셀 사이즈 계산 (다양한 디바이스에서 일관적인 디자인을 보여주기 위해서)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let textAreaHeight: CGFloat = 65
        
        let width: CGFloat = (collectionView.bounds.width - itemSpacing)/2
        let height: CGFloat = width * 10/7 + textAreaHeight // 즉, CollectionView의 세로길이 + 텍스트 부분의 세로길이
        return CGSize(width: width, height: height)
    }
}

class GridCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    func update(info: BountyInfo) {
       imgView.image = info.image
       nameLabel.text = info.name
       bountyLabel.text = "\(info.bounty)"
    }
}

//MARK: - ViewModel
class bountyViewModel {
    
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 44000000),
        BountyInfo(name: "luffy", bounty: 3000000000),
        BountyInfo(name: "nami", bounty: 16000000),
        BountyInfo(name: "robin", bounty: 80000000),
        BountyInfo(name: "sanji", bounty: 770000000),
        BountyInfo(name: "zoro", bounty: 120000000),
    ]
    // 현상금이 큰 순서대로 정렬
    var sortedList: [BountyInfo] {
        let sortedList = bountyInfoList.sorted { prev, next in
            return prev.bounty > next.bounty
        }
        return sortedList
    }
    
    var numOfBoutnyInfoList: Int {
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int) -> BountyInfo {
        return sortedList[index]
    }
}
