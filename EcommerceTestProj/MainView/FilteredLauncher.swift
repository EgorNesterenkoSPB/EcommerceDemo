import UIKit

class FilteredLauncher: NSObject {

    fileprivate var blackView = UIView() // background view for filtered view
    let whiteView = UIView()
    var brands = [String]()
    let brandTextField = UITextField()
    let brandPickerView = UIPickerView()
    let priceTextField = UITextField()
    let pricePickerView = UIPickerView()
    var priceRange:[Int] {
        var priceRange = [Int]()
        for i in 0...10000 {
            if i == 0 || i % 500 == 0 {
                priceRange.append(i)
            }
        }
        return priceRange
    }
    let defaults = UserDefaults.standard
    let sizeTextField = UITextField()
    enum ConstantValueUI:CGFloat {
        case whiteViewCornerRadius = 20
        case cancelButtonCornerRadius = 11
        case brandLabelTopAnchor = 30
        case labelFont = 15
        case brandTextFieldTopAnchor = 5
        case brandTextFieldRightAnchor = -20
        enum DoneButton:CGFloat {
            case font = 15
        }
        enum TopLabel:CGFloat {
            case font = 15
            case topAnchor = 20
        }
        enum CancelButton:CGFloat {
            case leftAnchor = 20
        }
        enum PriceLabel:CGFloat {
            case topAnchor = 5
        }
        enum PriceTextField:CGFloat {
            case topAnchor = 5
        }
        enum PriceDownChevron:CGFloat {
            case rightAnchor = -20
        }
        enum SizeLabel:CGFloat {
            case topAnchor = 5
        }
        enum SizeTextField:CGFloat {
            case topAnchor = 5
        }
        enum SizeDownChevron:CGFloat {
            case rightAnchor = -20
        }
    }


    
    //MARK: - Setup view
    public func showBottomView(brands:[String]) {
        self.brands = brands
        if let window = UIApplication.shared.windows.first(where: \.isKeyWindow) {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            blackView.frame = window.frame
            blackView.alpha = 0
            window.addSubview(blackView)
        
            whiteView.translatesAutoresizingMaskIntoConstraints = false
            whiteView.backgroundColor = .white
            whiteView.layer.cornerRadius = ConstantValueUI.whiteViewCornerRadius.rawValue
            whiteView.alpha = 0
            whiteView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
            window.addSubview(whiteView)
            
            let topLabel = UILabel()
            topLabel.translatesAutoresizingMaskIntoConstraints = false
            topLabel.text = "Filter options"
            topLabel.textColor = UIColor(named: ConstantName.tabBarColorName)
            topLabel.font = .boldSystemFont(ofSize: ConstantValueUI.TopLabel.font.rawValue)
            whiteView.addSubview(topLabel)
            
            let cancelButton = UIButton()
            cancelButton.translatesAutoresizingMaskIntoConstraints = false
            cancelButton.setImage(UIImage(systemName: "xmark"), for: .normal)
            cancelButton.tintColor = .white
            cancelButton.backgroundColor = UIColor(named: ConstantName.tabBarColorName)
            cancelButton.layer.cornerRadius = ConstantValueUI.cancelButtonCornerRadius.rawValue
            cancelButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            whiteView.addSubview(cancelButton)
            
            let doneButton = UIButton()
            doneButton.translatesAutoresizingMaskIntoConstraints = false
            doneButton.backgroundColor = UIColor(named: ConstantName.orangeMainColor)
            doneButton.setTitle("Done", for: .normal)
            doneButton.setTitleColor(.white, for: .normal)
            doneButton.layer.cornerRadius = ConstantValueUI.cancelButtonCornerRadius.rawValue
            doneButton.titleLabel?.font = .boldSystemFont(ofSize: ConstantValueUI.DoneButton.font.rawValue)
            whiteView.addSubview(doneButton)
            
            let brandLabel = self.createLabel(text: "Brand")
            whiteView.addSubview(brandLabel)
            
            let brandDownChevronIV = self.createDownChevroneIV()
            if let previousPhoneName = defaults.string(forKey: ConstantName.previousBrandProneNameKey) {
                self.setUpTextField(textField: brandTextField, text: previousPhoneName, imageView: brandDownChevronIV)
            }
            else {
                self.setUpTextField(textField: brandTextField, text: brands[0], imageView: brandDownChevronIV)
            }
            whiteView.addSubview(brandTextField)
            
            let priceLabel = self.createLabel(text: "Price")
            whiteView.addSubview(priceLabel)
            
            let priceDownChevronIV = self.createDownChevroneIV()
            
            let previousMinPriceValue = defaults.string(forKey: ConstantName.previousMinPriceValueKey)
            let previousMaxPriceValue = defaults.string(forKey: ConstantName.previousMaxPriceValueKey)
            
            let currentMinPrice = previousMinPriceValue != nil ? previousMinPriceValue! : String(priceRange[0])
            let currentMaxPrice = previousMaxPriceValue != nil ? previousMaxPriceValue! : String(priceRange[priceRange.count - 1])
            
            self.setUpTextField(textField: priceTextField, text: "$\(currentMinPrice) - $\(currentMaxPrice)", imageView: priceDownChevronIV)

            whiteView.addSubview(priceTextField)
            
            let sizeLabel = self.createLabel(text: "Size")
            whiteView.addSubview(sizeLabel)
            
            let sizeDownChevronIV = self.createDownChevroneIV()
            self.setUpTextField(textField: sizeTextField, text: "4.5 to 5.5 inches", imageView: sizeDownChevronIV) // hardcode
            sizeTextField.isEnabled = false // hardcode
            whiteView.addSubview(sizeTextField)
            
            self.createPickerView()
            self.dismissAndClosePickerView()
            
            NSLayoutConstraint.activate([
                whiteView.heightAnchor.constraint(equalToConstant: window.frame.height / 3),
                whiteView.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor),
                whiteView.rightAnchor.constraint(equalTo: window.safeAreaLayoutGuide.rightAnchor),
                whiteView.leftAnchor.constraint(equalTo: window.safeAreaLayoutGuide.leftAnchor),
                topLabel.topAnchor.constraint(equalTo: whiteView.topAnchor,constant: ConstantValueUI.TopLabel.topAnchor.rawValue),
                topLabel.centerXAnchor.constraint(equalTo: whiteView.centerXAnchor),
                cancelButton.centerYAnchor.constraint(equalTo: topLabel.centerYAnchor),
                cancelButton.leftAnchor.constraint(equalTo: whiteView.leftAnchor,constant: ConstantValueUI.CancelButton.leftAnchor.rawValue),
                cancelButton.widthAnchor.constraint(equalToConstant: cancelButton.frame.width + 35),
                cancelButton.heightAnchor.constraint(equalToConstant: cancelButton.frame.width + 35),
                doneButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
                doneButton.rightAnchor.constraint(equalTo: whiteView.rightAnchor, constant: -20),
                doneButton.widthAnchor.constraint(equalToConstant: doneButton.frame.width + 70),
                doneButton.heightAnchor.constraint(equalToConstant: doneButton.frame.height + 35),
                brandLabel.topAnchor.constraint(equalTo: cancelButton.bottomAnchor,constant: ConstantValueUI.brandLabelTopAnchor.rawValue),
                brandLabel.leftAnchor.constraint(equalTo: cancelButton.leftAnchor),
                brandTextField.leftAnchor.constraint(equalTo: brandLabel.leftAnchor),
                brandTextField.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: ConstantValueUI.brandTextFieldTopAnchor.rawValue),
                brandTextField.rightAnchor.constraint(equalTo: whiteView.rightAnchor,constant: -20),
                brandTextField.heightAnchor.constraint(equalToConstant: brandTextField.frame.height + 30),
                brandDownChevronIV.centerYAnchor.constraint(equalTo: brandTextField.centerYAnchor),
                brandDownChevronIV.rightAnchor.constraint(equalTo: brandTextField.rightAnchor, constant: ConstantValueUI.brandTextFieldRightAnchor.rawValue),
                priceLabel.leftAnchor.constraint(equalTo: brandLabel.leftAnchor),
                priceLabel.topAnchor.constraint(equalTo: brandTextField.bottomAnchor, constant: ConstantValueUI.PriceLabel.topAnchor.rawValue),
                priceTextField.leftAnchor.constraint(equalTo: priceLabel.leftAnchor),
                priceTextField.rightAnchor.constraint(equalTo: brandTextField.rightAnchor),
                priceTextField.heightAnchor.constraint(equalTo: brandTextField.heightAnchor),
                priceTextField.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: ConstantValueUI.PriceTextField.topAnchor.rawValue),
                priceDownChevronIV.centerYAnchor.constraint(equalTo: priceTextField.centerYAnchor),
                priceDownChevronIV.rightAnchor.constraint(equalTo: priceTextField.rightAnchor, constant: ConstantValueUI.PriceDownChevron.rightAnchor.rawValue),
                sizeLabel.leftAnchor.constraint(equalTo: brandLabel.leftAnchor),
                sizeLabel.topAnchor.constraint(equalTo: priceTextField.bottomAnchor,constant: ConstantValueUI.SizeLabel.topAnchor.rawValue),
                sizeTextField.leftAnchor.constraint(equalTo: priceTextField.leftAnchor),
                sizeTextField.rightAnchor.constraint(equalTo: priceTextField.rightAnchor),
                sizeTextField.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: ConstantValueUI.SizeTextField.topAnchor.rawValue),
                sizeTextField.heightAnchor.constraint(equalTo: brandTextField.heightAnchor),
                sizeDownChevronIV.centerYAnchor.constraint(equalTo: sizeTextField.centerYAnchor),
                sizeDownChevronIV.rightAnchor.constraint(equalTo: sizeTextField.rightAnchor, constant: ConstantValueUI.SizeDownChevron.rightAnchor.rawValue)
            ])
            
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 0.3
                self.whiteView.alpha = 1
            })
        }
    }
    
    //MARK: - Private setup UI methods
    @objc private func handleDismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            self.whiteView.alpha = 0
        })
    }
    
    private func createDownChevroneIV() -> UIImageView {
        let downChevronIV = UIImageView(image: UIImage(systemName: "chevron.down"))
        downChevronIV.translatesAutoresizingMaskIntoConstraints = false
        downChevronIV.tintColor = .gray
        return downChevronIV
    }
    
    private func setUpTextField(textField:UITextField,text:String,imageView:UIImageView) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 5
        textField.delegate = self
        textField.text = "     \(text)"
        textField.textColor = UIColor(named: ConstantName.tabBarColorName)
        textField.addSubview(imageView)
    }
    
    private func createLabel(text:String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = UIColor(named: ConstantName.tabBarColorName)
        label.font = .boldSystemFont(ofSize: ConstantValueUI.labelFont.rawValue)
        return label
    }
    
    private func createPickerView() {
        pricePickerView.delegate = self
        pricePickerView.dataSource = self
        brandPickerView.delegate = self
        brandPickerView.dataSource = self
        brandTextField.inputView = brandPickerView
        priceTextField.inputView = pricePickerView
    }
    
    private func createToolbar( tag:Int) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissAction(_:)))
        doneButton.tag = tag
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        return toolbar
    }
    
    private func dismissAndClosePickerView() {
        brandTextField.inputAccessoryView = self.createToolbar(tag: 0)
        priceTextField.inputAccessoryView = self.createToolbar(tag: 1)
    }
    
    @objc private func dismissAction(_ sender:UIButton) {
        switch sender.tag {
        case 0:
            brandTextField.endEditing(true)
        case 1:
            priceTextField.endEditing(true)
        default:
            break
        }
        
    }

}

//MARK: - Picker and TextField methods
extension FilteredLauncher:UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView {
        case brandPickerView:
            return 1
        case pricePickerView:
            return 2
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case brandPickerView:
            return brands.count
        case pricePickerView:
            return priceRange.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case brandPickerView:
            return brands[row]
        case pricePickerView:
            return String(priceRange[row])
        default:
            return ""
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case brandPickerView:
            defaults.set(brands[row], forKey: ConstantName.previousBrandProneNameKey)
            brandTextField.text = "     \(brands[row])"
        case pricePickerView:
            if component == 0 {
                defaults.set(priceRange[row], forKey: ConstantName.previousMinPriceValueKey)
                if let previousMaxPriceValue = defaults.string(forKey: ConstantName.previousMaxPriceValueKey) {
                    priceTextField.text = "     $\(priceRange[row]) - $\(previousMaxPriceValue)"
                }
                else {
                    priceTextField.text = "     $\(priceRange[row]) - $\(priceRange[priceRange.count - 1])"
                }
            }
            else {
                defaults.set(priceRange[row], forKey: ConstantName.previousMaxPriceValueKey)
                if let previousMinPriceValue = defaults.string(forKey: ConstantName.previousMinPriceValueKey) {
                    priceTextField.text = "     $\(previousMinPriceValue) - $\(priceRange[row])"
                }
                else {
                     priceTextField.text = "     $\(priceRange[0]) - $\(priceRange[row])"
                }
            }
        default:
            break
        }
    }
}
