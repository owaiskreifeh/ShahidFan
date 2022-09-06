//
//  TextInput.swift
//  ShahidUIElements
//
//  Created by Owais Kreifeh on 04/09/2022.
//
import UIKit



class TextInputView: UITextField {
    let padding = UIEdgeInsets(top: 0, left: K.cornerRadius, bottom: 0, right: K.cornerRadius)
    
    var disabled: Bool = false {
        didSet {
            if (disabled){
                backgroundColor = AppColors.DisabledBackground;
                textColor = AppColors.DisabledText;
            } else {
                backgroundColor = AppColors.InputBackground
                textColor = AppColors.InputText;
            }
        }
    }
    
    var active: Bool = false {
        didSet {
            if (active){
                layer.borderColor = AppColors.InputTextBorderActive.cgColor;
            } else {
                layer.borderColor = AppColors.InputTextBorderNormal.cgColor;
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        style(); // @TODO:
        layout(); // @TODO:
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 280.0, height: 64.0)
    }
    
    override var placeholder: String? {
        didSet {
            if let placeholder = placeholder {
                attributedPlaceholder = NSAttributedString(
                    string: placeholder,
                    attributes: [NSAttributedString.Key.foregroundColor: AppColors.DisabledText]
                )
            }
        }
    }
    
    

}

extension TextInputView {
    
    func setup() {
        
    }
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false;
        layer.cornerRadius = K.cornerRadius;
        clipsToBounds = true;
        layer.borderColor = AppColors.InputTextBorderNormal.cgColor;
        layer.borderWidth = 2;
        
        backgroundColor = AppColors.InputBackground
        textColor = AppColors.InputText;

    }
    
    func layout() {
        
    }
    
}

// MARK: - Padding
extension TextInputView {
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
