  import UIKit

  final class AddGoalViewController: UIViewController {
    
    
    let viewModel = AddGoalViewModel()
    

    // 모달 뷰
    let modalMainView: UIView = {
      let view = UIView()
      return view
    }()
    
    // 목표명 입력받기
    let goalTextField: UITextField = {
      let textField = UITextField()
      applyCommonTextFieldStyle(textField)
      textField.placeholder = "목표를 입력하세요"
      textField.keyboardType = .default
      return textField
    }()
    
    // 초기값
    let initValueTextField: UITextField = {
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
    
    // 목적값
    let goalValueTextField: UITextField = {
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
        initValueTextField,
        formLabel,
        goalValueTextField,
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
            let goalValueText = goalValueTextField.text, let goalValueNumber = Double(goalValueText),
            let initValueText = initValueTextField.text, let initValueNumber = Double(initValueText) else {
        showAlert(message: "모든 항목을 입력해주세요.")
        return
      }
      
      // 첫 설정 0
      var untilGoal: Double = 0
      // 수정시 계산을 위해 초기값 = 현재값a
      var currentValue: Double = initValueNumber
      

      
      // 양수만 입력 가능하게
      if goalValueNumber <= 0 || initValueNumber <= 0 {
        showAlert(message: "양수 값으로 입력해 주세요.")
        return
      }
      
      var selectedChangeType: ChangeType {
        return ChangeType(rawValue: changeType.selectedSegmentIndex) ?? .decrease
      }
      
      //값 검사
      switch selectedChangeType {
      case .decrease:
        if goalValueNumber > initValueNumber {
          showAlert(message: "목표가 현재값보다 큽니다. 값을 확인해주세요.")
          return
        }
        untilGoal = initValueNumber - goalValueNumber
        
        
      case .increase:
        if goalValueNumber < initValueNumber {
          showAlert(message: "목표가 현재값보다 작습니다. 값을 확인해주세요.")
          return
        }
        untilGoal = goalValueNumber - initValueNumber
        
      }
      
      
      let newGoal = Goal(
        goal: goal,
        initValue: initValueNumber,
        currentValue: initValueNumber, //처음에는 현재값 = 초기값
        goalValue: goalValueNumber,
        unit: unit,
        type: selectedChangeType
      )
      
      viewModel.delegate?.didAddGoal(newGoal)

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


