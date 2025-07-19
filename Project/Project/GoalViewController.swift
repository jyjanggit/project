import UIKit

//공통
let commonFontBold: UIFont = .systemFont(ofSize: 25, weight: .bold)
let commonFontRegular: UIFont = .systemFont(ofSize: 25)
let commonFontColor = UIColor(hex: "#1B2631")
func applyCommonButtonStyle(_ button: UIButton) {
  button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
  button.setTitleColor(.white, for: .normal)
}


final class GoalViewController: UIViewController {
  
  //스크롤뷰
  lazy var scView: UIScrollView = {
    let scv = UIScrollView()
    scv.backgroundColor = UIColor(hex: "#bdd3fc")
    return scv
  }()
  
  //목표 단락
  lazy var goalView: UIView = {
    let v = UIView()
    v.layer.cornerRadius = 10
    v.clipsToBounds = true
    v.backgroundColor = .white
    return v
  }()
  
  //목표명
  lazy var goalNameLabel: UILabel = {
    let l = UILabel()
    l.font = commonFontBold
    l.textColor = commonFontColor
    return l
  }()
  
  //최종목표
  lazy var goalLabel: UILabel = {
    let l = UILabel()
    l.font = commonFontBold
    l.textColor = commonFontColor
    return l
  }()
  
  //공통단위라벨
  static func makeUnitLabel() -> UILabel {
    let l = UILabel()
    l.font = commonFontBold
    l.textColor = commonFontColor
    return l
  }
  
  //단위라벨
  let unitLabel1 = makeUnitLabel()
  let unitLabel2 = makeUnitLabel()
  
  //증가,감량
  lazy var weightChangeLabel: UILabel = {
    let l = UILabel()
    l.text = "증가까지"
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
    return l
  }()
  
  //프로그래스바
  lazy var progressView: UIProgressView = {
    let p = UIProgressView(progressViewStyle: .default)
    p.progress = 0.7 //임시
    p.trackTintColor = .lightGray
    p.progressTintColor = .systemBlue
    return p
  }()
  
  //프로그래스바 %
  lazy var progressGoalLabel: UILabel = {
    let l = UILabel()
    l.text = "100%"
    l.font = .systemFont(ofSize: 18)
    l.textColor = UIColor(hex: "#181818")
    return l
  }()
  
  //수정버튼
  lazy var updateButton: UIButton = {
    let b = UIButton(type: .system)
    b.setTitle("수정", for: .normal)
    b.backgroundColor = .systemBlue
    applyCommonButtonStyle(b)
    return b
  }()
  
  //삭제버튼
  lazy var deleteButton: UIButton = {
    let b = UIButton(type: .system)
    b.setTitle("삭제", for: .normal)
    b.backgroundColor = .systemRed
    applyCommonButtonStyle(b)
    return b
  }()
  
  //스택뷰
  lazy var goalInfoStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [goalNameLabel, goalLabel, unitLabel1])
    stack.axis = .horizontal
    stack.spacing = 8
    stack.alignment = .center
    return stack
  }()
  
  lazy var progressInfoStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [weightChangeLabel, untilLabel, goalLeftLabel, unitLabel2])
    stack.axis = .horizontal
    stack.spacing = 8
    stack.alignment = .center
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
  }
  
  private func setupLayout() {
    
    
    
    
  }
  
  
}
