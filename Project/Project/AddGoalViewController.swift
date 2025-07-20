import UIKit

final class AddGoalViewController: UIViewController {
  
  //뷰
  lazy var modalMainView: UIView = {
    let v = UIView()
    return v
  }()
  
  //목표입력받기
  lazy var goalTextField: UITextField = {
    let tf = UITextField()
    applyCommonTextFieldStyle(tf)
    tf.placeholder = "목표를 입력하세요"
    tf.keyboardType = .default
    return tf
  }()
  
  //현재
  lazy var currentTextField: UITextField = {
    let tf = UITextField()
    applyCommonTextFieldStyle(tf)
    tf.keyboardType = .numberPad
    return tf
  }()
  
  //~에서
  lazy var formLabel: UILabel = {
    let l = UILabel()
    l.font = commonFontRegular
    l.textColor = commonFontColor
    l.text = "에서"
    return l
  }()
  
  //목적
  lazy var goalNumberTextField: UITextField = {
    let tf = UITextField()
    applyCommonTextFieldStyle(tf)
    tf.keyboardType = .numberPad
    return tf
  }()
  
  //~까지
  lazy var untilLabel: UILabel = {
    let l = UILabel()
    l.font = commonFontRegular
    l.textColor = commonFontColor
    l.text = "까지"
    return l
  }()
  
  //단위
  lazy var unitTextField: UITextField = {
    let tf = UITextField()
    applyCommonTextFieldStyle(tf)
    tf.placeholder = "단위"
    tf.keyboardType = .default
    return tf
  }()
  
  //감량 증가 택1
  lazy var changeType: UISegmentedControl = {
    let sc = UISegmentedControl(items: ["감소", "증가"])
    sc.selectedSegmentIndex = 0
    
    let selectedFont = UIFont.boldSystemFont(ofSize: 20)
    let selectedAttributes: [NSAttributedString.Key: Any] = [
        .font: selectedFont,
        .foregroundColor: UIColor(hex: "#87BFFF")
    ]
    sc.setTitleTextAttributes(selectedAttributes, for: .selected)
    sc.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    return sc
  }()
  
  
  
  @objc func segmentChanged(sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 {
      
    } else {
      
    }
  }
  
  //스택뷰
  lazy var fromToStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [
      currentTextField,
      formLabel,
      goalNumberTextField,
      untilLabel
    ])
    stack.axis = .horizontal
    stack.spacing = 8
    stack.alignment = .center
    stack.distribution = .fillEqually
    return stack
  }()
  
  lazy var unitStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [
      unitTextField,
      changeType
    ])
    stack.axis = .horizontal
    stack.spacing = 8
    stack.alignment = .center
    stack.distribution = .fillEqually
    return stack
  }()

  lazy var goalInputStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [
      goalTextField,
      fromToStackView,
      unitStackView
    ])
    stack.axis = .vertical
    stack.spacing = 20
    stack.alignment = .fill
    stack.distribution = .equalSpacing
    return stack
  }()
  
  
  
  
  
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    modal()
    setupLayout()
  }
  
  private func modal() {
    view.backgroundColor = .white
    
    title = "목표 추가"
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "취소",
      style: .plain,
      target: self,
      action: #selector(dismissModal)
    )
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "확인",
      style: .done,
      target: self,
      action: #selector(confirmAction)
    )
  }
  
  @objc private func dismissModal() {
    self.dismiss(animated: true)
  }
  @objc private func confirmAction() {
    self.dismiss(animated: true)
  }
  
  private func setupLayout() {
    
    view.addSubview(goalInputStackView)
    
    goalInputStackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      
      
      goalInputStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      goalInputStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
      goalInputStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
      

      
      
    ])
    
  }
}


