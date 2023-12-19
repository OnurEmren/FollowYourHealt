//
//  FitViewController.swift
//  FollowYourHealt
//
//  Created by Onur Emren on 23.11.2023.
//

import UIKit


class FitViewController: UIViewController {
    
    private var selectedItem: String?
    private var fitView: FitView
    var coordinator: Coordinator?
    private var viewModel: FitViewModel
    
    init(viewModel: FitViewModel) {
        self.viewModel = viewModel
        self.fitView = FitView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        self.fitView.coordinator = coordinator 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Fit Kal"
        navigationItem.title = "Fit Kal"
        view.backgroundColor = .brown
        setView()
        fitView.goToShowRecordsButton.addTarget(self, action: #selector(goToDetail), for: .touchUpInside)
        
    }
    
    private func setView() {
        
        fitView = FitView(viewModel: viewModel)
        fitView.coordinator = coordinator
        view.addSubview(fitView)
        fitView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc
    private func goToDetail() {
        viewModel.goToShowRecords()
    }
}
