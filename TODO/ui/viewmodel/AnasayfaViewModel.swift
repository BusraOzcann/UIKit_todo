//
//  AnasayfaViewModel.swift
//  TODO
//
//  Created by Büşra Özcan on 4.10.2023.
//

import Foundation
import RxSwift

class AnasayfaViewModel{
    var repo = TodoDaoRepository()
    
    var todoList = BehaviorSubject<[Todo]>(value: [Todo]())
    
    
    init(){
        repo.veritabaniKopyala()
        todoList = repo.todoList
    }
    
    func ara(aramaKelimesi:String){
        repo.ara(aramaKelimesi: aramaKelimesi)
    }
    
    func sil(todo_id:Int){
        repo.sil(todo_id:todo_id)
    }
    
    func listele(){
        repo.todoListele()
    }
}
