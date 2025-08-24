import UIKit

final class GoalViewController: UIViewController {
  
  private let viewModel = GoalViewModel()
  private let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 180)
    layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    layout.minimumLineSpacing = 20
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = UIColor(hex: "#F7F8FA")
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate = self
    
    collectionView.dataSource = self
    collectionView.register(GoalViewCell.self, forCellWithReuseIdentifier: GoalViewCell.identifier)
    
    setupLayout()
    navi()
  }
  
  private func setupLayout() {
    view.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
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
    let viewController = AddGoalViewController()
    viewController.viewModel.delegate = self
    let navi = UINavigationController(rootViewController: viewController)
    navi.modalPresentationStyle = .formSheet
    present(navi, animated: true)
  }
}

extension GoalViewController: AddGoalViewModelDelegate {
  func didAddGoal(_ goal: Goal) {
    viewModel.addGoal(goal)
  }
}

extension GoalViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.countGoal()
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalViewCell.identifier, for: indexPath) as! GoalViewCell
    if let goal = viewModel.goalIndex(at: indexPath.item) {
      cell.configure(with: goal)
    }
    return cell
  }
}

extension GoalViewController: GoalViewModelDelegate {
  func didAddGoals(_ goals: [Goal]) {
    collectionView.reloadData()
  }
}
