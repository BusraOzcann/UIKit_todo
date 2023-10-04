//
//  Detay.swift
//  TODO
//
//  Created by Büşra Özcan on 4.10.2023.
//

import UIKit

class Detay: UIViewController {
    var viewModel = DetayViewModel()
    
    var todo:Todo?

    @IBOutlet weak var tfName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let t = todo {
            tfName.text = t.todo_name
        }
    }
    
    @IBAction func guncelleBtn(_ sender: Any) {
        if let name = tfName.text, let id = todo?.todo_id{
            viewModel.guncelle(todo_id: id, todo_name: name)
            
            self.navigationController?.popToRootViewController(animated: true)

        }
        
    }
}
