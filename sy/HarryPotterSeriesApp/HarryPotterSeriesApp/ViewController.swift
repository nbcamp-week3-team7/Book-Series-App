//
//  ViewController.swift
//  HarryPotterSeriesApp
//
//  Created by shinyoungkim on 3/28/25.
//

import UIKit

class ViewController: UIViewController {
    private let dataService = DataService()
    var books = Array<Book>()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadBooks()
        print(books)
    }
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                self.books = books
            case .failure(let error):
                print(error)
            }
        }
    }
}

