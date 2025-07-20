import UIKit

final class GoalViewController: UIViewController {
  
  //스크롤뷰
  lazy var scView: UIScrollView = {
    let scv = UIScrollView()
    scv.backgroundColor = UIColor(hex: "#F7F8FA")
    return scv
  }()
  
  //목표 단락
  lazy var goalView: UIView = {
    let v = UIView()
    v.layer.cornerRadius = 10
    v.clipsToBounds = true
    v.backgroundColor = .white
    v.layer.shadowColor = UIColor(hex: "#1b2631").cgColor
    v.layer.shadowOpacity = 0.2
    v.layer.shadowRadius = 8
    v.layer.shadowOffset = CGSize(width: 0, height: 4)
    return v
  }()
  
  //목표명
  lazy var goalNameLabel: UILabel = {
    let l = UILabel()
    l.font = commonFontBold
    l.textColor = commonFontColor
    l.text = "근육량"
    return l
  }()
  
  //최종목표
  lazy var goalLabel: UILabel = {
    let l = UILabel()
    l.font = commonFontBold
    l.textColor = commonFontColor
    l.text = "25"
    return l
  }()
  
  //공통단위라벨
  func makeUnitLabel() -> UILabel {
    let l = UILabel()
    l.font = commonFontBold
    l.textColor = commonFontColor
    l.text = "kg"
    return l
  }
  
  //단위라벨
  lazy var unitLabel1 = makeUnitLabel()
  lazy var unitLabel2 = makeUnitLabel()
  
  //증가,감량
  lazy var weightChangeLabel: UILabel = {
    let l = UILabel()
    l.text = "증가"
    l.font = commonFontBold
    l.textColor = commonFontColor
    return l
  }()
  
  //목표까지
  lazy var untilLabel: UILabel = {
    let l = UILabel()
    l.font = commonFontRegular
    l.textColor = commonFontColor
    l.text = "목표까지"
    return l
  }()
  
  //최종목표
  lazy var goalLeftLabel: UILabel = {
    let l = UILabel()
    l.font = commonFontBold
    l.textColor = commonFontColor
    l.text = "2"
    return l
  }()
  
  //프로그래스바
  lazy var progressView: UIProgressView = {
    let p = UIProgressView(progressViewStyle: .default)
    p.progress = 0.5 //임시
    p.trackTintColor = .lightGray
    p.progressTintColor = .systemBlue
    return p
  }()
  
  //프로그래스바 %
  lazy var progressGoalLabel: UILabel = {
    let l = UILabel()
    l.text = "50%"
    l.font = .systemFont(ofSize: 18)
    l.textColor = UIColor(hex: "#181818")
    return l
  }()
  
  //수정버튼
  lazy var updateButton: UIButton = {
    let b = UIButton(type: .system)
    b.setTitle("현재 상태 수정", for: .normal)
    b.backgroundColor = UIColor(hex: "#87BFFF")
    b.layer.cornerRadius = 10
    b.clipsToBounds = true
    applyCommonButtonStyle(b)
    return b
  }()
  
  //삭제버튼
  lazy var deleteButton: UIButton = {
    let b = UIButton(type: .system)
    b.setTitle("삭제", for: .normal)
    b.backgroundColor = UIColor(hex: "#FF8B8B")
    b.layer.cornerRadius = 10
    b.clipsToBounds = true
    applyCommonButtonStyle(b)
    return b
  }()
  
  //스택뷰
  let goalsStackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.alignment = .fill
    stack.spacing = 8
    return stack
  }()
  
  lazy var goalInfoStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [goalNameLabel, goalLabel, unitLabel1, UIView()])
    stack.axis = .horizontal
    stack.spacing = 8
    stack.alignment = .center
    stack.distribution = .fill
    return stack
  }()
  
  lazy var progressInfoStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [weightChangeLabel, untilLabel, goalLeftLabel, unitLabel2, UIView()])
    stack.axis = .horizontal
    stack.spacing = 8
    stack.alignment = .center
    stack.distribution = .fill
    return stack
  }()
  
  lazy var progressBarStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [progressView, progressGoalLabel])
    stack.axis = .horizontal
    stack.spacing = 8
    stack.alignment = .center
    return stack
  }()
  
  lazy var actionButtonStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [updateButton, deleteButton])
    stack.axis = .horizontal
    stack.spacing = 12
    stack.alignment = .center
    stack.distribution = .fillEqually
    return stack
  }()
  
  lazy var goalSummaryStackView: UIStackView = {
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    //네비게이션바
    navi()
  }
  
  private func navi() {
    self.title = "현재 목표"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addTapped)
    )
    
  }
  
  @objc private func addTapped() {
    let vc = AddGoalViewController()
    let nav = UINavigationController(rootViewController: vc)
    nav.modalPresentationStyle = .formSheet
    present(nav, animated: true)
  }
  
  private func setupLayout() {
    
    view.addSubview(scView)
    scView.addSubview(goalsStackView)
    goalsStackView.addArrangedSubview(goalView)
    goalView.addSubview(goalSummaryStackView)
    
    scView.translatesAutoresizingMaskIntoConstraints = false
    goalsStackView.translatesAutoresizingMaskIntoConstraints = false
    goalView.translatesAutoresizingMaskIntoConstraints = false
    goalSummaryStackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      scView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      scView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      scView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      
      goalsStackView.topAnchor.constraint(equalTo: scView.contentLayoutGuide.topAnchor, constant: 16),
      goalsStackView.leadingAnchor.constraint(equalTo: scView.contentLayoutGuide.leadingAnchor, constant: 16),
      goalsStackView.trailingAnchor.constraint(equalTo: scView.contentLayoutGuide.trailingAnchor, constant: -16),
      goalsStackView.bottomAnchor.constraint(equalTo: scView.contentLayoutGuide.bottomAnchor, constant: -16),
      goalsStackView.widthAnchor.constraint(equalTo: scView.frameLayoutGuide.widthAnchor, constant: -32),
      
      goalSummaryStackView.topAnchor.constraint(equalTo: goalView.topAnchor, constant: 16),
      goalSummaryStackView.leadingAnchor.constraint(equalTo: goalView.leadingAnchor, constant: 16),
      goalSummaryStackView.trailingAnchor.constraint(equalTo: goalView.trailingAnchor, constant: -16),
      goalSummaryStackView.bottomAnchor.constraint(equalTo: goalView.bottomAnchor, constant: -16)
    ])
  }
}
