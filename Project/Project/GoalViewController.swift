import UIKit

final class GoalViewController: UIViewController, AddGoalViewControllerDelegate {
  
  // 스크롤뷰
  let scView: UIScrollView = {
    let scroll = UIScrollView()
    scroll.backgroundColor = UIColor(hex: "#F7F8FA")
    return scroll
  }()
  
  // 컨텐츠 묶음
  let goalsStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .fill
    stack.spacing = 8
    return stack
  }()
  
  // 화면 표시
  override func viewDidLoad() {
    super.viewDidLoad()
    // 전체적 레이아웃
    setupLayout()
    // 네비게이션바
    navi()
  }
  
  // 전체적 레이아웃
  private func setupLayout() {
    view.addSubview(scView)
    scView.addSubview(goalsStackView)
    
    scView.translatesAutoresizingMaskIntoConstraints = false
    goalsStackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      scView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      scView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      scView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      goalsStackView.topAnchor.constraint(equalTo: scView.contentLayoutGuide.topAnchor, constant: 16),
      goalsStackView.leadingAnchor.constraint(equalTo: scView.contentLayoutGuide.leadingAnchor, constant: 16),
      goalsStackView.trailingAnchor.constraint(equalTo: scView.contentLayoutGuide.trailingAnchor, constant: -16),
      goalsStackView.bottomAnchor.constraint(equalTo: scView.contentLayoutGuide.bottomAnchor, constant: -16),
      goalsStackView.widthAnchor.constraint(equalTo: scView.frameLayoutGuide.widthAnchor, constant: -32)
    ])
  }
  
  // 네비게이션바
  private func navi() {
    self.title = "현재 목표"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addTapped)
    )
  }
  
  // 네비게이션바 + 동작
  @objc private func addTapped() {
    let viewController = AddGoalViewController()
    viewController.delegate = self
    let navi = UINavigationController(rootViewController: viewController)
    navi.modalPresentationStyle = .formSheet
    present(navi, animated: true)
  }
  
  
  
  // 델리게이트
  func didAddGoal(goal: String, target: Double, unit: String, type: Int, initPercent: Double, initProgress: Double, untilGoal: Double) {
    let newGoalView = createGoalView(
      goalName: goal,
      targetValue: target,
      unit: unit,
      type: type,
      untilGoal: untilGoal,
      initPercent: initPercent,
      initProgress: initProgress
    )
    goalsStackView.addArrangedSubview(newGoalView)
  }
  
  // 생성
  private func createGoalView(goalName: String,
                              targetValue: Double,
                              unit: String,
                              type: Int,
                              untilGoal: Double,
                              initPercent: Double,
                              initProgress: Double) -> UIView {
    
    // goalView
    let goalView = UIView()
    goalView.layer.cornerRadius = 10
    goalView.clipsToBounds = true
    goalView.backgroundColor = .white
    goalView.layer.shadowColor = UIColor(hex: "#1b2631").cgColor
    goalView.layer.shadowOpacity = 0.2
    goalView.layer.shadowRadius = 8
    goalView.layer.shadowOffset = CGSize(width: 0, height: 4)
    
    // 공통단위라벨
    func makeUnitLabel() -> UILabel {
      let label = UILabel()
      label.font = commonFontBold
      label.textColor = commonFontColor
      label.text = unit
      label.setContentHuggingPriority(.required, for: .horizontal)
      label.setContentCompressionResistancePriority(.required, for: .horizontal)
      return label
    }
    
    // 목표명
    let goalNameLabel: UILabel = {
      let label = UILabel()
      label.font = commonFontBold
      label.textColor = commonFontColor
      label.text = goalName
      label.setContentHuggingPriority(.defaultLow, for: .horizontal)
      label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
      return label
    }()
    
    // 최종목표
    let goalLabel: UILabel = {
      let label = UILabel()
      label.font = commonFontBold
      label.textColor = commonFontColor
      label.text = String(format: "%.2f", targetValue)
      label.setContentHuggingPriority(.required, for: .horizontal)
      label.setContentCompressionResistancePriority(.required, for: .horizontal)
      return label
    }()
    
    // 단위라벨 1, 2
    let unitLabel1 = makeUnitLabel()
    let unitLabel2 = makeUnitLabel()
    
    // 증가,감량
    let weightChangeLabel: UILabel = {
      let label = UILabel()
      label.text = (type == 0) ? "감소" : "증가"
      label.font = commonFontBold
      label.textColor = commonFontColor
      return label
    }()
    
    // 목표까지
    let untilLabel: UILabel = {
      let label = UILabel()
      label.font = commonFontRegular
      label.textColor = commonFontColor
      label.text = "목표까지"
      return label
    }()
    
    // 목표까지 수치
    let goalLeftLabel: UILabel = {
      let label = UILabel()
      label.font = commonFontBold
      label.textColor = commonFontColor
      label.text = String(format: "%.2f", untilGoal)
      return label
    }()
    
    // 프로그래스바
    let progressView: UIProgressView = {
      let progressBar = UIProgressView(progressViewStyle: .default)
      progressBar.progress = Float(initProgress)
      progressBar.trackTintColor = .lightGray
      progressBar.progressTintColor = .systemBlue
      return progressBar
    }()
    
    // 프로그래스바 %
    let progressGoalLabel: UILabel = {
      let label = UILabel()
      label.text = String(format: "%.0f%%", initPercent * 100)
      label.font = .systemFont(ofSize: 18)
      label.textColor = UIColor(hex: "#181818")
      return label
    }()
    
    // 수정버튼
    let updateButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitle("현재 상태 수정", for: .normal)
      button.backgroundColor = UIColor(hex: "#87BFFF")
      button.layer.cornerRadius = 10
      button.clipsToBounds = true
      applyCommonButtonStyle(button)
      return button
    }()
    
    // 삭제버튼
    let deleteButton: UIButton = {
      let button = UIButton(type: .system)
      button.setTitle("삭제", for: .normal)
      button.backgroundColor = UIColor(hex: "#FF8B8B")
      button.layer.cornerRadius = 10
      button.clipsToBounds = true
      applyCommonButtonStyle(button)
      return button
    }()
    


    
    // 목표 정보 스택뷰
    let goalInfoStackView: UIStackView = {
      let stack = UIStackView(arrangedSubviews: [goalNameLabel, goalLabel, unitLabel1, UIView()])
      stack.axis = .horizontal
      stack.spacing = 8
      stack.alignment = .center
      stack.distribution = .fill
      return stack
    }()
    
    // 진행 정보 스택뷰
    let progressInfoStackView: UIStackView = {
      let stack = UIStackView(arrangedSubviews: [weightChangeLabel, untilLabel, goalLeftLabel, unitLabel2, UIView()])
      stack.axis = .horizontal
      stack.spacing = 8
      stack.alignment = .center
      stack.distribution = .fill
      return stack
    }()
    
    // 프로그래스바 스택뷰
    let progressBarStackView: UIStackView = {
      let stack = UIStackView(arrangedSubviews: [progressView, progressGoalLabel])
      stack.axis = .horizontal
      stack.spacing = 8
      stack.alignment = .center
      return stack
    }()
    
    // 액션버튼 스택뷰
    let actionButtonStackView: UIStackView = {
      let stack = UIStackView(arrangedSubviews: [updateButton, deleteButton])
      stack.axis = .horizontal
      stack.spacing = 12
      stack.alignment = .center
      stack.distribution = .fillEqually
      return stack
    }()
    
    // 메인 스택뷰
    let mainStackView: UIStackView = {
      let stack = UIStackView(arrangedSubviews: [
        goalInfoStackView,
        progressInfoStackView,
        progressBarStackView,
        actionButtonStackView
      ])
      stack.axis = .vertical
      stack.spacing = 10
      stack.alignment = .fill
      stack.distribution = .equalSpacing
      return stack
    }()
    
    goalView.addSubview(mainStackView)
    mainStackView.translatesAutoresizingMaskIntoConstraints = false


    
    NSLayoutConstraint.activate([
      mainStackView.topAnchor.constraint(equalTo: goalView.topAnchor, constant: 16),
      mainStackView.leadingAnchor.constraint(equalTo: goalView.leadingAnchor, constant: 16),
      mainStackView.trailingAnchor.constraint(equalTo: goalView.trailingAnchor, constant: -16),
      mainStackView.bottomAnchor.constraint(equalTo: goalView.bottomAnchor, constant: -16)
    ])
    
    return goalView
  }
}
