import UIKit

final class GoalViewCell: UICollectionViewCell {
  static let identifier = "GoalCollectionViewCell"
  
  // MARK: - UI 컴포넌트들
  
  private let goalNameLabel: UILabel = {
    let label = UILabel()
    label.font = commonFontBold
    label.textColor = commonFontColor
    label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    return label
  }()
  
  private let goalValueLabel: UILabel = {
    let label = UILabel()
    label.font = commonFontBold
    label.textColor = commonFontColor
    label.setContentHuggingPriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    return label
  }()
  
  private func makeUnitLabel(text: String = "") -> UILabel {
    let label = UILabel()
    label.font = commonFontBold
    label.textColor = commonFontColor
    label.text = text
    label.setContentHuggingPriority(.required, for: .horizontal)
    label.setContentCompressionResistancePriority(.required, for: .horizontal)
    return label
  }
  
  private lazy var unitLabel1 = makeUnitLabel()
  private lazy var unitLabel2 = makeUnitLabel()
  
  private let weightChangeLabel: UILabel = {
    let label = UILabel()
    label.font = commonFontBold
    label.textColor = commonFontColor
    return label
  }()
  
  private let untilLabel: UILabel = {
    let label = UILabel()
    label.font = commonFontRegular
    label.textColor = commonFontColor
    label.text = "목표까지"
    return label
  }()
  
  private let goalLeftLabel: UILabel = {
    let label = UILabel()
    label.font = commonFontBold
    label.textColor = commonFontColor
    return label
  }()
  
  private let progressView: UIProgressView = {
    let progressBar = UIProgressView(progressViewStyle: .default)
    progressBar.trackTintColor = .lightGray
    progressBar.progressTintColor = .systemBlue
    return progressBar
  }()
  
  private let progressGoalLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18)
    label.textColor = UIColor(hex: "#181818")
    return label
  }()
  
  private let updateButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("현재 상태 수정", for: .normal)
    button.backgroundColor = UIColor(hex: "#87BFFF")
    button.layer.cornerRadius = 10
    button.clipsToBounds = true
    applyCommonButtonStyle(button)
    return button
  }()
  
  private let deleteButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("삭제", for: .normal)
    button.backgroundColor = UIColor(hex: "#FF8B8B")
    button.layer.cornerRadius = 10
    button.clipsToBounds = true
    applyCommonButtonStyle(button)
    return button
  }()
  
  // MARK: - 스택뷰 구성
  
  private lazy var goalInfoStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [goalNameLabel, goalValueLabel, unitLabel1, UIView()])
    stack.axis = .horizontal
    stack.spacing = 8
    stack.alignment = .center
    stack.distribution = .fill
    return stack
  }()
  
  private lazy var progressInfoStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [weightChangeLabel, untilLabel, goalLeftLabel, unitLabel2, UIView()])
    stack.axis = .horizontal
    stack.spacing = 8
    stack.alignment = .center
    stack.distribution = .fill
    return stack
  }()
  
  private lazy var progressBarStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [progressView, progressGoalLabel])
    stack.axis = .horizontal
    stack.spacing = 8
    stack.alignment = .center
    return stack
  }()
  
  private lazy var actionButtonStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [updateButton, deleteButton])
    stack.axis = .horizontal
    stack.spacing = 12
    stack.alignment = .center
    stack.distribution = .fillEqually
    return stack
  }()
  
  private lazy var mainStackView: UIStackView = {
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
  
  // MARK: - 초기화
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    contentView.backgroundColor = UIColor(hex: "#FFFFFF")
    contentView.layer.cornerRadius = 10
    contentView.clipsToBounds = true
    
    contentView.addSubview(mainStackView)
    mainStackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    ])
  }
  
  // MARK: - 데이터 연결 함수
  
  func configure(with goal: Goal) {
    goalNameLabel.text = goal.goal
    goalValueLabel.text = String(format: "%.2f", goal.goalValue)
    unitLabel1.text = goal.unit
    unitLabel2.text = goal.unit
    weightChangeLabel.text = goal.type == .decrease ? "감소" : "증가"
    
    // 목표까지 수치 계산 (예: initValue - goalValue 또는 goalValue - initValue)
    let untilGoalValue: Double
    switch goal.type {
    case .decrease:
      untilGoalValue = goal.currentValue - goal.goalValue
    case .increase:
      untilGoalValue = goal.goalValue - goal.currentValue
    }
    goalLeftLabel.text = String(format: "%.2f", untilGoalValue)
    
    // 프로그래스 계산 (진행률)
    let progress = Float((goal.currentValue - goal.initValue) / (goal.goalValue - goal.initValue))
    progressView.progress = max(0, min(progress, 1)) // 0~1 사이로 제한
    
    let percent = progress * 100
    progressGoalLabel.text = String(format: "%.0f%%", percent)
  }
}

