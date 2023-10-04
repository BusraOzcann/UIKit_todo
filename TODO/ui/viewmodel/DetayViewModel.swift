//
//  DetayViewModel.swift
//  TODO
//
//  Created by Büşra Özcan on 4.10.2023.
//

import Foundation

class DetayViewModel{
    var repo = TodoDaoRepository()
    
    func guncelle(todo_id:Int, todo_name:String){
        repo.guncelle(todo_id:todo_id, todo_name:todo_name)
    }
}
