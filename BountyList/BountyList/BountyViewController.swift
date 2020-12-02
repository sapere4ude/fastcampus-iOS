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
extension BountyViewController: UITableViewDataSource, UITableViewDelegate {

    // UITableViewDataSource : 셀 몇개야?, 어떻게 보여줄까?에 대한 대답
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return bountyInfoList.count
        return viewModel.numOfBoutnyInfoList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // indexPath는 cell의 위치를 의미
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        
        let bountyInfo = viewModel.bountyInfo(at: indexPath.row)

        cell.update(info: bountyInfo)
        
        return cell
    }
    
    // UITableViewDelegate : 클릭 했을때의 결과를 알려줌
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("--> \(indexPath.row)")
        performSegue(withIdentifier: "showDetail", sender: indexPath.row) // 식별자는 세그웨이의 identifier이다. 세그웨이가 실행될 때 indexPath.row 라는 데이터도 보내주는 것
    }
    
    
}

class ListCell: UITableViewCell {
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
        BountyInfo(name: "luffy", bounty: 30000000),
        BountyInfo(name: "nami", bounty: 16000000),
        BountyInfo(name: "robin", bounty: 80000000),
        BountyInfo(name: "sanji", bounty: 770000000),
        BountyInfo(name: "zoro", bounty: 120000000),
    ]
    
    var numOfBoutnyInfoList: Int {
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int) -> BountyInfo {
        return bountyInfoList[index]
    }
}
