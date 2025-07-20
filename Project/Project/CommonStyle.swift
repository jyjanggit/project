import UIKit

//공통
let commonFontBold: UIFont = .systemFont(ofSize: 25, weight: .bold)
let commonFontRegular: UIFont = .systemFont(ofSize: 25)
let commonFontColor = UIColor(hex: "#1B2631")

func applyCommonButtonStyle(_ button: UIButton) {
  button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
  button.setTitleColor(.white, for: .normal)
}

func applyCommonTextFieldStyle(_ textField: UITextField) {
  textField.borderStyle = .roundedRect
  textField.font = commonFontRegular
  textField.textColor = commonFontColor
  textField.clearButtonMode = .whileEditing
  textField.autocorrectionType = .no
  textField.autocapitalizationType = .none
}
