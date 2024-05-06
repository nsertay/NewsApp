//
//  SegmentedControllerCell.swift
//  NewsApp
//
//  Created by Nurmukhanbet Sertay on 06.05.2024.
//

import UIKit

class SegmentedControllerCell: UITableViewCell {
    
    static let identifier = "SegmentedControllerCell"
    
    weak var delegate: SegmentedValueChangedDelegate?
    
    let segmentedController: UISegmentedControl = {
        let segmentedController = UISegmentedControl()
        segmentedController.insertSegment(withTitle: "Все новости", at: 0, animated: true)
        segmentedController.insertSegment(withTitle: "Изрбранные", at: 1, animated: true)
        segmentedController.selectedSegmentIndex = 0
        
        return segmentedController
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setupConstraints()
        setupTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(segmentedController)
    }
    
    func setupConstraints() {
        segmentedController.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(40)
        }
    }
    
    func setupTarget() {
        segmentedController.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        delegate?.valueChanged(index: sender.selectedSegmentIndex)
    }
}
