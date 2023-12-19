//
//  FitView.swift
//  FollowYourHealt
//
//  Created by Onur Emren on 23.11.2023.
//


import UIKit
import SnapKit

class FitView: UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    private let viewModel: FitViewModel
    var coordinator: Coordinator?
    var selectedHeight: Int = 160
    var selectedWeight: Int = 60
    let heightRange = Array(140...200)
    let weightRange = Array(40...120)
    
    private let bmiColors: [ClosedRange<Double>: UIColor] = [
        0.0...18.4: .systemBlue,
        18.5...24.9: .systemGreen,
        25.0...29.9: .systemOrange,
        30.0...34.9: .systemYellow,
        35.0...39.9: .systemRed,
        40.0...100.0: .systemPurple
    ]
    
    var boyTextField: UITextField!
    var kiloTextField: UITextField!
    var boyPickerView: UIPickerView!
    var kiloPickerView: UIPickerView!
    var hesaplaButton: UIButton!
    var kaydetButton: UIButton!
    var gosterButton: UIButton!
    var bmiLabel: UILabel = UILabel()
    
    
    //MARK: - Init
    
    init(viewModel: FitViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setGestureRecognizer()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setupUI() {
        backgroundColor = Colors.appMainColor
        createUI()
    }
    
    //MARK: - Setup Views
    
    func createUI() {
        boyTextField = createTextField()
        kiloTextField = createTextField()
        boyPickerView = createPickerView()
        kiloPickerView = createPickerView()
        hesaplaButton = createButton(title: "Hesapla", action: #selector(calculateBMI))
        kaydetButton = createButton(title: "Verileri Kaydet", action: #selector(saveData))
        gosterButton = createButton(title: "Verileri Göster", action: #selector(goToShowRecords))
        
        addSubview(boyTextField)
        addSubview(kiloTextField)
        addSubview(hesaplaButton)
        addSubview(kaydetButton)
        addSubview(gosterButton)
        addSubview(bmiLabel)
        
        boyTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.centerY.equalToSuperview().dividedBy(1.5)
            make.width.equalToSuperview().dividedBy(1.5)
        }
        
        kiloTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(boyTextField.snp.bottom).offset(10)
            make.width.equalToSuperview().dividedBy(1.5)
        }
        
        hesaplaButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(kiloTextField.snp.bottom).offset(20)
        }
        
        kaydetButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(hesaplaButton.snp.bottom).offset(10)
        }
        
        gosterButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(kaydetButton.snp.bottom).offset(10)
        }
        
        bmiLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(gosterButton.snp.bottom).offset(20)
        }
        
        boyTextField.inputView = boyPickerView
        kiloTextField.inputView = kiloPickerView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPickerViews))
        addGestureRecognizer(tapGesture)
    }
    
    func createTextField() -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    }
    
    func createPickerView() -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = Colors.pickerViewColor
        return pickerView
    }
    
    func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    // MARK: - PickerViews Delegate
    
    @objc func dismissPickerViews() {
        boyTextField.resignFirstResponder()
        kiloTextField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == boyPickerView {
            return weightRange.count
        } else {
            return heightRange.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == boyPickerView {
            return String("\(heightRange[row]) Cm")
        } else {
            return String("\(weightRange[row]) Kg")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == boyPickerView {
            boyTextField.text = String("\(heightRange[row]) Cm")
        } else {
            kiloTextField.text = String("\(weightRange[row]) Kg")
        }
    }
    
    //MARK: - Private funcs
    
    @objc
    private func goToShowRecords() {
        coordinator?.eventOccored(with: .goToShowRecordsVC)
    }
    
    private func setGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func handleTap() {
        self.endEditing(true)
    }
    
    @objc
    private func saveData() {
        viewModel.saveLesson(weight: selectedWeight, height: selectedHeight)
        self.superview?.showToast(message: "Kayıt Başarılı")
    }
    
    @objc
    private func calculateBMI() {
        let bmi = viewModel.calculateBMI(weight: selectedWeight, height: selectedHeight)
        viewModel.saveBmi(bmiValue: bmi)
        
        let color = colorForBMI(bmi)
        bmiLabel.text = "BMI: \(bmi)"
        bmiLabel.textColor = color
        self.superview?.showToast(message: "BMI Hesaplandı ve Kaydedildi")
        
    }
    
    private func colorForBMI(_ bmi: Double) -> UIColor {
        for (range, color) in bmiColors {
            if range.contains(bmi) {
                return color
            }
        }
        return .black
    }
}

//MARK: - Extensions

extension UIView {
    func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: self.frame.size.width/2 - 150, y: self.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.boldSystemFont(ofSize: 15)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        self.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1.0, delay: 0.2, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
}


extension UITextField {
    func setTextField(_ placeHolder: String) {
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        self.borderStyle = .roundedRect
        self.textColor = .brown
        self.backgroundColor = Colors.color4
        self.placeholder = placeHolder
    }
}

extension UIPickerView {
    func setPickerView() {
        self.backgroundColor = Colors.appMainColor
        self.tintColor = .brown
    }
}
g
