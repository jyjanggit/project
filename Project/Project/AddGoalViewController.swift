import UIKit

final class AddGoalViewController: UIViewController {
  
  
  weak var delegate: addGoalViewControllerDelegate?
  
  enum ChangeType: Int {
    case decrease = 0 //감소 선택
    case increase = 1 //증가 선택
  }
  
  
  
  // 뷰
  let modalMainView: UIView = {
    let view = UIView()
    return view
  }()
  
  // 목표입력받기
  let goalTextField: UITextField = {
    let textField = UITextField()
    applyCommonTextFieldStyle(textField)
    textField.placeholder = "목표를 입력하세요"
    textField.keyboardType = .default
    return textField
  }()
  
  // 현재
  let currentTextField: UITextField = {
    let textField = UITextField()
    applyCommonTextFieldStyle(textField)
    textField.keyboardType = .numberPad
    return textField
  }()
  
  // ~에서
  let formLabel: UILabel = {
    let label = UILabel()
    label.font = commonFontRegular
    label.textColor = commonFontColor
    label.text = "에서"
    return label
  }()
  
  // 목적
  let goalNumberTextField: UITextField = {
    let textField = UITextField()
    applyCommonTextFieldStyle(textField)
    textField.keyboardType = .numberPad
    return textField
  }()
  
  // ~까지
  let untilLabel: UILabel = {
    let label = UILabel()
    label.font = commonFontRegular
    label.textColor = commonFontColor
    label.text = "까지"
    return label
  }()
  
  // 단위
  let unitTextField: UITextField = {
    let textField = UITextField()
    applyCommonTextFieldStyle(textField)
    textField.placeholder = "단위"
    textField.keyboardType = .default
    return textField
  }()
  
  // 감량 증가 택1
  let changeType: UISegmentedControl = {
    let segmentControl = UISegmentedControl(items: ["감소", "증가"])
    segmentControl.selectedSegmentIndex = 0
    
    let selectedFont = UIFont.boldSystemFont(ofSize: 20)
    let selectedAttributes: [NSAttributedString.Key: Any] = [
      .font: selectedFont,
      .foregroundColor: UIColor(hex: "#87BFFF")
    ]
    segmentControl.setTitleTextAttributes(selectedAttributes, for: .selected)
    return segmentControl
  }()
  
  
  
  // 스택뷰
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
    
    // 유효성 검사
    guard let goal = goalTextField.text, !goal.isEmpty,
          let unit = unitTextField.text, !unit.isEmpty,
          let targetText = goalNumberTextField.text, let target = Double(targetText),
          let currentText = currentTextField.text, let currentValue = Double(currentText) else {
      showAlert(message: "모든 항목을 입력해주세요.")
      return
    }
    
    // 첫 설정 0
    var untilGoal: Double = 0
    
    var selectedChangeType: ChangeType {
      return ChangeType(rawValue: changeType.selectedSegmentIndex) ?? .decrease
    }
    
    // 양수만 입력 가능하게
    if target <= 0 || currentValue <= 0 {
      showAlert(message: "양수 값으로 입력해 주세요.")
      return
    }
    
    
    //값 검사
    switch selectedChangeType {
    case .decrease:
      if target >= currentValue {
        showAlert(message: "목표가 현재값보다 크거나 같습니다. 값을 확인해주세요.")
        return
      }
      untilGoal = currentValue - target
    case .increase:
      if target <= currentValue {
        showAlert(message: "목표가 현재값보다 작거나 같습니다. 값을 확인해주세요.")
        return
      }
      untilGoal = target - currentValue
    }
    
    //처음엔 프로그래스바 진행도 0,퍼센트도 0
    delegate?.didAddGoal(goal: goal,
                         target: target,
                         unit: unit,
                         type: selectedChangeType.rawValue,
                         initPercent: 0,
                         initProgess: 0,
                         untilGoal: untilGoal)
    
    self.dismiss(animated: true)
  }
  
  //알럿 창
  private func showAlert(message: String) {
    let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "확인", style: .default))
    self.present(alert, animated: true)
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


