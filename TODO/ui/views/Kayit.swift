//
//  Kayit.swift
//  TODO
//
//  Created by Büşra Özcan on 4.10.2023.
//

import UIKit

class Kayit: UIViewController {
    var viewModel = KayitViewModel()

    @IBOutlet weak var tfName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func kayitBtn(_ sender: Any) {
        if let name = tfName.text{
            viewModel.kaydet(todo_name: name)
            self.navigationController?.popToRootViewController(animated: true)
        }
        
    }
    
}
