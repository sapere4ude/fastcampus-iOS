//
//  ViewController.swift
//  BountyList
//
//  Created by sapere4ude on 2020/12/01.
//

import UIKit

class BountyViewController: UIViewController {

    let nameList = ["brook", "chopper", "franky", "luffy", "nami", "robin", "sanji", "zoro"]
    let bountyList = [33000000, 50, 44000000, 30000000, 16000000, 80000000, 770000000, 120000000]
    
    // Segue를 호출하기 직전에 준비해주는 것. DetailViewController에게 데이터를 주는 것
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            
            if let index = sender as? Int {  // Any로 받았던 것을 Int로 다운캐스팅
                vc?.name = nameList[index]
                vc?.bounty = bountyList[index]
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
        return bountyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // indexPath는 cell의 위치를 의미
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        
        // indexPath는 [section,row]로 이루어져 있는 행을 식별하는 상대적인 경로
        let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
        cell.imgView.image = img
        cell.nameLabel.text = nameList[indexPath.row]
        cell.bountyLabel.text = "\(bountyList[indexPath.row])"
        
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
}
