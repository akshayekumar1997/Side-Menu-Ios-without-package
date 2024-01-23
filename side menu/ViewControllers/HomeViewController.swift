//
//  HomeViewController.swift
//  side menu
//
//  Created by SUMSKAR PC on 22/01/24.
//

import UIKit
protocol HomeViewControllerDelegate:AnyObject{
    func didTapMenuButton()
}
class HomeViewController: UIViewController {
    weak var delegate:HomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title="Home"
        navigationItem.leftBarButtonItem=UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .done, target: self, action: #selector(didTapMenuButton))
       
    }
    

  @objc func didTapMenuButton(){
      print("You tapped me")
      delegate?.didTapMenuButton()
    }

}
