//
//  KayitViewModel.swift
//  TODO
//
//  Created by Büşra Özcan on 4.10.2023.
//

import Foundation


class KayitViewModel{
    var repo = TodoDaoRepository()
    
    func kaydet(todo_name:String){
        repo.kaydet(todo_name: todo_name)
    }
}
