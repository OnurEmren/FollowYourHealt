//
//  AppCoordinator.swift
//  FollowYourHealt
//
//  Created by Onur Emren on 23.11.2023.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOccored(with type: Event, data: Any?) {
        switch type {
        case .goToDetailVC:
            if let selectedItem = data as? String {
                let detailViewController = FitViewController(selectedItem: selectedItem)
                navigationController?.pushViewController(detailViewController, animated: true)
            }        }
    }
    
    func start() {
         navigationController = UINavigationController()
         let viewModel = HomeViewModel(coordinator: self)
         let vc = HomeViewController(viewModel: viewModel)
         navigationController?.setViewControllers([vc], animated: false)
     }
}
