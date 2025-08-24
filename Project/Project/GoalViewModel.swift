import Foundation

protocol GoalViewModelDelegate: AnyObject {
  func didAddGoals(_ goals: [Goal])
}

final class GoalViewModel {
  
  private var goals: [Goal] = []
  
  weak var delegate: GoalViewModelDelegate?
  
  func addGoal(_ goal: Goal) {
    goals.append(goal)
    delegate?.didAddGoals(goals)
  }
  
  func countGoal() -> Int {
    return goals.count
  }
  
  func goalIndex(at index: Int) -> Goal? {
    guard index >= 0 && index < goals.count else { return nil }
    return goals[index]
  }
}
