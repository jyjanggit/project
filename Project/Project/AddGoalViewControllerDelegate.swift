import Foundation

protocol addGoalViewControllerDelegate: AnyObject {
  func didAddGoal(goal: String,target: Double, unit: String, type: Int, initPercent: Double, initProgess: Double, untilGoal: Double)
}
