//
//  ViewController.swift
//  materialtextfield
//
//  Created by Azimjon on 26/12/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrool = UIScrollView()
        view.addSubview(scrool)
        scrool.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrool.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrool.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrool.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrool.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        let stack = UIStackView(arrangedSubviews: [
            {
                let view = MaterialTextField()
                view.placeholder = "1234567"
                
                let x = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                x.backgroundColor = .red
                view.leftView = x
                view.leftViewMode = .unlessEditing
                let y = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                y.backgroundColor = .red
                view.rightView = y
                view.rightViewMode = .unlessEditing
                
                view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                view.lineMode = .none
                return view
            }(),
            {
                let view = MaterialTextField()
                view.placeholder = "1234567"
                
                let x = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                x.backgroundColor = .red
                view.leftView = x
                view.leftViewMode = .always
                let y = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                y.backgroundColor = .red
                view.rightView = y
                view.rightViewMode = .always
                
                view.setBorder(width: 10, for: .active)
                view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                view.labelFloatingMode = .always
                view.lineMode = .underline
                return view
            }(),
            {
                let view = MaterialTextField()
                view.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                view.cornerRadius = 20
                view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                view.setBorder(color: .blue, for: .active)
                view.placeholder = "1234567"
//                view.setBorder(color: .yellow, for: .filled)
                
                let x = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                x.backgroundColor = .red
                view.leftView = x
                view.leftViewMode = .always
                let y = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                y.backgroundColor = .red
                view.rightView = y
                view.rightViewMode = .always
                
                return view
            }(),
            {
                let view = MaterialTextField()
                view.placeholder = "1234567"
                
                let x = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                x.backgroundColor = .red
                view.leftView = x
                view.leftViewMode = .always
                let y = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                y.backgroundColor = .red
                view.rightView = y
                view.rightViewMode = .always
                
                view.heightAnchor.constraint(equalToConstant: 40).isActive = true
                view.labelFloatingMode = .never
                return view
            }(),
            {
                let mat = MaterialTextField()
                mat.placeholder = "1234567"
                mat.labelFloatingMode = .automatic
                mat.lineMode = .underline
                mat.heightAnchor.constraint(equalToConstant: 48).isActive = true
                mat.padding = UIEdgeInsets(top: 0, left: 10, bottom: 8, right: 10)
                mat.translatesAutoresizingMaskIntoConstraints = false
                
                let viewForAkmalhon = UIView()
                viewForAkmalhon.heightAnchor.constraint(equalToConstant: 56).isActive = true
                viewForAkmalhon.backgroundColor = .cyan
                viewForAkmalhon.addSubview(mat)
                NSLayoutConstraint.activate([
                    mat.topAnchor.constraint(equalTo: viewForAkmalhon.topAnchor, constant: 8),
                    mat.leadingAnchor.constraint(equalTo: viewForAkmalhon.leadingAnchor),
                    mat.trailingAnchor.constraint(equalTo: viewForAkmalhon.trailingAnchor),
                    mat.bottomAnchor.constraint(equalTo: viewForAkmalhon.bottomAnchor),
                ])
                return viewForAkmalhon
            }(),
        ])
        stack.axis = .vertical
        stack.spacing = 25
        scrool.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: scrool.contentLayoutGuide.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: scrool.contentLayoutGuide.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: scrool.contentLayoutGuide.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: scrool.contentLayoutGuide.bottomAnchor),
            stack.widthAnchor.constraint(equalTo: scrool.widthAnchor, constant: -40)
        ])
        
        
        view.viewWithTag(6969)?.isHidden = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fuck)))
    }
    
    @objc func fuck() {
        view.endEditing(true)
    }
    
}


extension MaterialTextField {
    
    enum LabelFlotingMode {
        case automatic
        case always
        case never
    }
    
    enum LineMode {
        case none
        case underline
        case outline
    }
    
    enum State {
        case normal
        case active
//        case filled
//        case activeAndFilled
    }
    
}


class MaterialTextField : UITextField {
    
    var isLabelFloating = true
    var cornerRadius: CGFloat = 4.0
    let labelSidePadding: CGFloat = 5.0
    
    var label: UILabel!
    private var labelFrame: CGRect!
    
    private(set) var currentState: State = .normal
    private var borderColors: [State: UIColor] = [.normal: .black]
    private var borderWidths: [State: CGFloat] = [.normal: 1, .active: 2]
    
    var labelFloatingMode: LabelFlotingMode! {
        didSet { labelFloatingModeChanged() }
    }
    var lineMode: LineMode = .outline {
        didSet { setNeedsLayout() }
    }
    var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) {
        didSet {
            labelFloatingModeChanged()
            setNeedsLayout()
        }
    }
    var leftViewSpacing: CGFloat = 10 {
        didSet { setNeedsLayout() }
    }
    var rightViewSpacing: CGFloat = 10 {
        didSet { setNeedsLayout() }
    }
    
    override var text: String? {
        didSet {
            if labelFloatingMode == .automatic && (text?.isEmpty ?? true) == isLabelFloating {
                labelFloatingModeChanged()
            }
        }
    }
    
    var outlinedSublayer: CAShapeLayer = CAShapeLayer()
    private var leadingLabelAnchor: NSLayoutConstraint!
    private var trailingLabelAnchor: NSLayoutConstraint!
    private var centerYLabelAnchor: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - init functions
    private func setup() {
        setupLabel()
        setUpOutlineSublayer()
        addTarget(self, action: #selector(editingBegan), for: .editingDidBegin)
        addTarget(self, action: #selector(editingEnded), for: .editingDidEnd)
//        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .valueChanged)
        labelFloatingMode = LabelFlotingMode.automatic
    }
    
    private func setupLabel() {
        label = UILabel()
        label.clipsToBounds = false
        label.text = "floating label"
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        leadingLabelAnchor = label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0)
        trailingLabelAnchor = label.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: 0)
        let offset = (self.padding.top - self.padding.bottom) / 2
        centerYLabelAnchor = label.centerYAnchor.constraint(equalTo: self.topAnchor, constant: offset)
        
        NSLayoutConstraint.activate([leadingLabelAnchor, trailingLabelAnchor, centerYLabelAnchor])
    }
    
    private func setUpOutlineSublayer() {
        self.outlinedSublayer = CAShapeLayer()
        self.outlinedSublayer.fillColor = UIColor.clear.cgColor;
        self.outlinedSublayer.lineWidth = 1;
    }
    
    // MARK: - label animations
    func floatLabel(animated: Bool) {
        self.isLabelFloating = true
        let oldConstraint = self.centerYLabelAnchor
        self.centerYLabelAnchor = self.label.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        if animated {
            self.label.animate(font: .systemFont(ofSize: 12), duration: 0.2)
            UIView.animate(withDuration: 0.2) {
                oldConstraint?.constant = -self.frame.height / 2
                self.layoutIfNeeded()
            } completion: { isFinished in
                guard isFinished else { return }
                oldConstraint?.isActive = false
                self.centerYLabelAnchor.isActive = true
            }
        } else {
            self.label.font = .systemFont(ofSize: 12)
            oldConstraint?.isActive = false
            self.centerYLabelAnchor.isActive = true
        }
        placeholder = _placeholder
    }

    func unfloatLabel(animated: Bool) {
        self.isLabelFloating = false
        let oldConstraint = self.centerYLabelAnchor
        let offset = (self.padding.top - self.padding.bottom) / 2
        self.centerYLabelAnchor = self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: offset)
        if animated {
            self.label.animate(font: .systemFont(ofSize: 15), duration: 0.2)
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut]) {
                oldConstraint?.constant = self.frame.height / 2 + offset
                self.layoutIfNeeded()
            } completion: { isFinished in
                guard isFinished else { return }
                oldConstraint?.isActive = false
                self.centerYLabelAnchor.isActive = true
            }
        } else {
            self.label.font = .systemFont(ofSize: 15)
            oldConstraint?.isActive = false
            self.centerYLabelAnchor.isActive = true
        }
        placeholder = _placeholder
    }
    
    func labelFloatingModeChanged() {
        var animated = true
        if !self.isHidden && !(self.window?.isKeyWindow ?? false) {
            // if view is not loaded
            animated = false
        }
        
        self.label.isHidden = labelFloatingMode == .never
        
        if labelFloatingMode == .always {
            if !self.isLabelFloating { floatLabel(animated: animated) }
        } else if labelFloatingMode == .automatic {
            if self.isEditing || !(self.text?.isEmpty ?? true) {
                floatLabel(animated: animated)
            } else {
                if self.isLabelFloating {
                    unfloatLabel(animated: animated)
                } else {
                    let offset = (padding.top - padding.bottom) / 2
                    centerYLabelAnchor.constant = offset
                }
            }
        } else {
            unfloatLabel(animated: animated)
        }
    }
    
    @objc func editingBegan() {
        if labelFloatingMode == .automatic, !self.isLabelFloating {
            floatLabel(animated: true)
        }
    }
    
    @objc func editingEnded() {
        if labelFloatingMode == .automatic, self.isLabelFloating, self.text == "" {
            unfloatLabel(animated: true)
        }
    }
    
//    @objc func textFieldDidChange(_ textField: UITextField) {
//        print("textFieldDidChange")
//    }
    
    // MARK: - superclass functions
    override func layoutSubviews() {
        super.layoutSubviews()
        currentState = isEditing ? .active : .normal
        applyStyle()
    }
    
    private var _placeholder: String?
    override var placeholder: String? {
        set {
            _placeholder = newValue
            super.placeholder = isLabelFloating || labelFloatingMode == .never ? _placeholder : nil
        }
        get {
            return _placeholder
        }
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let padding = getPaddingWithSideViews()
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let padding = getPaddingWithSideViews()
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let padding = getPaddingWithSideViews()
        return bounds.inset(by: padding)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x = padding.left
        return rect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds.inset(by: padding))
//        rect.origin.x = padding.left
        return rect
    }
    
    private func getPaddingWithSideViews() -> UIEdgeInsets {
        var padding = padding
        if let leftView = leftView, leftViewMode == .always || (leftViewMode == .whileEditing && isEditing) || (leftViewMode == .unlessEditing && (!isEditing || text?.isEmpty ?? true)) {
            padding.left += leftView.frame.width + leftViewSpacing
        }
        if let rightView = rightView, rightViewMode == .always || (rightViewMode == .whileEditing && isEditing) || (rightViewMode == .unlessEditing && (!isEditing || text?.isEmpty ?? true)) {
            padding.right += rightView.frame.width + rightViewSpacing
        }
        return padding
    }
    
    // MARK: - style and properties
    func setBorder(color: UIColor, for state: State) {
        borderColors[state] = color
        setNeedsLayout()
    }
    
    func setBorder(width: CGFloat, for state: State) {
        borderWidths[state] = width
        setNeedsLayout()
    }
    
}


// MARK: - drawing border line
extension MaterialTextField {
    
    func applyStyle() {
        let labelFrame: CGRect = label.frame
        
        let padding = getPaddingWithSideViews()
        leadingLabelAnchor.constant = isLabelFloating ? cornerRadius + labelSidePadding : padding.left
        trailingLabelAnchor.constant = isLabelFloating ? -(cornerRadius + labelSidePadding) : -padding.right
        
        let path = outlinePath(
            with: frame,
            labelFrame: labelFrame,
            cornerRadius: cornerRadius,
            isLabelFloating: isLabelFloating
        )
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.outlinedSublayer.path = path.cgPath;
        
        let outlineLineWidth = borderWidths[currentState] ?? borderWidths[.normal]!
        self.outlinedSublayer.lineWidth = outlineLineWidth;
        CATransaction.commit()
        
        if self.outlinedSublayer.superlayer != self.layer {
            self.layer.insertSublayer(self.outlinedSublayer, at: 0)
        }
        
        let color = borderColors[currentState] ?? borderColors[.normal]!
        self.outlinedSublayer.strokeColor = color.cgColor
    }
    
    func outlinePath(with viewBounds: CGRect, labelFrame: CGRect, cornerRadius radius:CGFloat, isLabelFloating:Bool) -> UIBezierPath {
        let path = UIBezierPath()
        if self.lineMode == .none {
            return path
        }
        
        let textFieldWidth: CGFloat = viewBounds.width
        let sublayerMinY: CGFloat = 0
        let sublayerMaxY: CGFloat = viewBounds.height
        
        if self.lineMode == .underline {
            path.move(to: CGPointMake(0, sublayerMaxY))
            path.addLine(to: CGPointMake(textFieldWidth, sublayerMaxY))
            return path
        }
        
        let startingPoint: CGPoint = CGPointMake(radius, sublayerMinY)
        let topRightCornerPoint1: CGPoint = CGPointMake(textFieldWidth - radius, sublayerMinY)
        path.move(to: startingPoint)
        
        if (isLabelFloating) {
            let leftLineBreak: CGFloat = CGRectGetMinX(labelFrame) - labelSidePadding;
            let rightLineBreak: CGFloat = CGRectGetMaxX(labelFrame) + labelSidePadding;
            
            path.addLine(to: CGPointMake(leftLineBreak, sublayerMinY))
            path.move(to: CGPointMake(rightLineBreak, sublayerMinY))
            path.addLine(to: CGPointMake(rightLineBreak, sublayerMinY))
        } else {
            path.addLine(to: topRightCornerPoint1)
        }
        
        let topRightCornerPoint2: CGPoint = CGPointMake(textFieldWidth, sublayerMinY + radius)
        path.addTopRightCorner(from: topRightCornerPoint1, to: topRightCornerPoint2, with: radius)
        
        let bottomRightCornerPoint1: CGPoint = CGPointMake(textFieldWidth, sublayerMaxY - radius);
        let bottomRightCornerPoint2: CGPoint = CGPointMake(textFieldWidth - radius, sublayerMaxY);
        path.addLine(to: bottomRightCornerPoint1)
        path.addBottomRightCorner(from: bottomRightCornerPoint1, to: bottomRightCornerPoint2, with: radius)
        
        let bottomLeftCornerPoint1: CGPoint = CGPointMake(radius, sublayerMaxY);
        let bottomLeftCornerPoint2: CGPoint = CGPointMake(0, sublayerMaxY - radius);
        path.addLine(to: bottomLeftCornerPoint1)
        path.addBottomLeftCorner(from: bottomLeftCornerPoint1, to: bottomLeftCornerPoint2, with: radius)
        
        let topLeftCornerPoint1: CGPoint = CGPointMake(0, sublayerMinY + radius);
        let topLeftCornerPoint2: CGPoint = CGPointMake(radius, sublayerMinY);
        path.addLine(to: topLeftCornerPoint1)
        path.addTopLeftCorner(from: topLeftCornerPoint1, to: topLeftCornerPoint2, with: radius)
        
        return path
    }
    
}


// MARK: - extension funcs
extension UIBezierPath {
    
    func addTopRightCorner(from point1:CGPoint, to point2:CGPoint, with radius: CGFloat) {
        let startAngle: CGFloat = Double.pi * 3 / 2
        let endAngle:CGFloat = 0
        let center: CGPoint = CGPointMake(point1.x, point2.y)
        self.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    }

    func addBottomRightCorner(from point1:CGPoint, to point2: CGPoint, with radius: CGFloat) {
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = Double.pi / 2
        let center: CGPoint = CGPointMake(point2.x, point1.y)
        self.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    }

    func addBottomLeftCorner(from point1: CGPoint, to point2: CGPoint, with radius: CGFloat) {
        let startAngle: CGFloat = Double.pi / 2
        let endAngle: CGFloat = Double.pi
        let center: CGPoint = CGPointMake(point1.x, point2.y)
        self.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    }

    func addTopLeftCorner(from point1: CGPoint, to point2: CGPoint, with radius: CGFloat) {
        let startAngle: CGFloat = Double.pi
        let endAngle: CGFloat = Double.pi * 3 / 2
        let center:CGPoint = CGPointMake(point1.x + radius, point2.y + radius)
        self.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    }
    
}


extension UILabel {
    
    func animate(font: UIFont, duration: TimeInterval) {
        let oldFrame = frame
        let labelScale = self.font.pointSize / font.pointSize
        
        self.font = font
        let oldTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        let newOrigin = frame.origin
        frame.origin = oldFrame.origin // only for left aligned text
        self.layoutIfNeeded()
        UIView.animate(withDuration: duration) {
            self.frame.origin = newOrigin
            self.transform = oldTransform
            self.layoutIfNeeded()
        }
    }
    
}


//extension Dictionary where Key == MaterialTextField.State {
//    /// get value by state: if state doesn't exist it gets .normal, in case of .activeAndFilled its gets .active and if there is no even .active it gets .normal
//    func get(by state: Key) -> Value {
//        return self[state] ?? ((state == .activeAndFilled) ? (self[.active] ?? self[.normal]!) : self[.normal]!)
//    }
//}
