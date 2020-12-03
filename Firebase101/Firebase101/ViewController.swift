//
//  ViewController.swift
//  Firebase101
//
//  Created by sapere4ude on 2020/12/03.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let db = Database.database().reference()
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var numberOfCustomers: UILabel!
    
    var customers: [Customer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabel()
        //        saveBasicTypes()
        //        saveCustomers()
        fetchCustomers()
//        updateBasicTypes()
//        deleteBasicTypes()
    }
    
    func updateLabel() {
        // observeSingleEvent : 데이터를 가져오는 역할. of 뒤엔 가져온 데이터를 어떻게 할건지 작성.
        // 이곳에 적힌 value의 역할은 Any data changes at a location or, recursively, at any child node.
        db.child("firstData").observeSingleEvent(of: .value) { snapshot in
            print("-->\(snapshot)")
            
            let value = snapshot.value as? String ?? "no data"
            
            DispatchQueue.main.async {
                self.dataLabel.text = value
            }
        }
    }
    
    @IBAction func createCustomer(_ sender: Any) {
        saveCustomers()
    }
    @IBAction func fetchCustomer(_ sender: Any) {
        fetchCustomers()
    }
    @IBAction func updateCustomer(_ sender: Any) {
        updateCustomer()
    }
    
    func updateCustomer() {
        guard customers.isEmpty == false else {
            return
        }
        customers[0].name = "Yoo"
        
        let dictionary = customers.map { $0.toDictionary }
        db.updateChildValues(["customers": dictionary])
    }
    
    
    @IBAction func deleteCustomer(_ sender: Any) {
        deleteCustomer()
    }
    
    func deleteCustomer() {
        db.child("customers").removeValue()
    }
    
}

extension ViewController {
    func saveBasicTypes() {
        // 값 저장하는 방법
        // String, number, dictionary, array 를 서버로 보내는 것이 가능
        db.child("int").setValue(3)
        db.child("double").setValue(3.6)
        db.child("str").setValue("string value - 여러분 안녕")
        db.child("array").setValue(["a", "b", "c"])
        db.child("dictionary").setValue(["id": "anyID", "age": 10])
    }
    
    func saveCustomers() {
        // 책가게
        // 사용자를 저장하겠다
        // 모델 Customer + Book
        
        let books = [Book(title: "Good to Great", author: "Someone"), Book(title: "Hacking Growth", author: "Somebody")]
        let customer1 = Customer(id: "\(Customer.id)", name: "Son", books: books)
        Customer.id += 1
        let customer2 = Customer(id: "\(Customer.id)", name: "Dele", books: books)
        Customer.id += 1
        let customer3 = Customer(id: "\(Customer.id)", name: "Kane", books: books)
        Customer.id += 1
        
        db.child("customers").child(customer1.id).setValue(customer1.toDictionary)
        db.child("customers").child(customer2.id).setValue(customer2.toDictionary)
        db.child("customers").child(customer3.id).setValue(customer3.toDictionary)
    }
}

//MARK: - Read(Fetch) Data
extension ViewController {
    func fetchCustomers() {
        db.child("customers").observeSingleEvent(of: .value) { snapshot in
            print("--> snapshot 데이터의 형태(Array형태를 갖는다):\(snapshot.value)")
            do {
                let data = try JSONSerialization.data(withJSONObject: snapshot.value, options: [])
                let decoder = JSONDecoder()
                let customers: [Customer] = try decoder.decode([Customer].self, from: data)
                self.customers = customers
                DispatchQueue.main.async {
                    self.numberOfCustomers.text = "# of Customers: \(customers.count)"
                }
            } catch let error {
                print("--> Error: \(error.localizedDescription)")
            }
        }
    }
}

extension ViewController {
    func updateBasicTypes() {
//        db.child("int").setValue(3)
//        db.child("double").setValue(3.6)
//        db.child("int").setValue("string value - 여러분 안녕")
        
        db.updateChildValues(["int": 6])
        db.updateChildValues(["double": 5.4])
        db.updateChildValues(["str": "변경된 스트링"])
    }
    
    func deleteBasicTypes() {
        db.child("int").removeValue()
        db.child("double").removeValue()
        db.child("int").removeValue()
    }
}

struct Customer: Codable {
    let id: String
    var name: String
    let books: [Book]
    
    var toDictionary: [String: Any] {
        let booksArray = books.map { $0.toDictionary }
        let dict: [String: Any] = ["id": id, "name": name, "books": booksArray]
        return dict
    }
    
    static var id: Int = 0
}

struct Book: Codable {
    let title: String
    let author: String
    
    var toDictionary: [String: Any] {
        let dict: [String: Any] = ["title": title, "author": author]
        return dict
    }
}
