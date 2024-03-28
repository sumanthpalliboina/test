//
//  ViewController.swift
//  Test
//
//  Created by Palliboina on 25/03/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var turnActivityStatusBtn: UIButton!
    
    @IBOutlet weak var labelSegment: UILabel!
    @IBOutlet weak var uiSegementControl: UISegmentedControl!
    
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var inputResult: UILabel!
    
    @IBOutlet weak var input2: UITextField!
    
    @IBAction func sayHello(_ sender: Any) {
          print("Hello")
        if progressBar.progress < 1.0 {
            progressBar.setProgress(progressBar.progress + 0.1, animated: true)
        }
    }
    @IBAction func sayGoodBye(_ sender: UIButton) {
        print("Good Bye")
        if progressBar.progress > 0.0 {
            progressBar.setProgress(progressBar.progress - 0.1, animated: true)
        }
    }
    @IBAction func disableButtons(_ sender: UIButton) {
        for button in buttons {
            button.isEnabled.toggle()
        }
    }
    
    @IBAction func turnOnOffActivity(_ sender: Any) {
        if activity.isAnimating {
            activity.stopAnimating()
            turnActivityStatusBtn.setTitle("Turn On", for: .normal)
        }else{
            activity.startAnimating()
            turnActivityStatusBtn.setTitle("Turn Off", for: .normal)
        }
    }
    
    @IBAction func changeOption(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        switch sender.selectedSegmentIndex {
        case 0:
            labelSegment.text = "first tab"
            labelSegment.textColor = .purple
            
        case 1:
            labelSegment.text = "second tab"
            labelSegment.textColor = .red
            
        case 2:
            labelSegment.text = "third tab"
            labelSegment.textColor = .green
            
        default:
            labelSegment.text = "unknown"
            labelSegment.textColor = .blue
            
        }
        
    }
    
    @IBAction func trunSwitch(_ sender: UISwitch) {
        if sender.isOn {
            switchLabel.text = "Switch in On"
        }else{
            switchLabel.text = "Switch in Off"
        }
    }
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
        let currentValue = sender.value / 10
        progressBar.progress = currentValue
    }
    
    
    @IBAction func changedStepperValue(_ sender: UIStepper) {
        stepperLabel.text = String(sender.value)
    }
    @IBAction func saveInput(_ sender: UIButton) {
        assignTitleToLabel()
    }
    
    func assignTitleToLabel(){
        let text = input.text!.trimmingCharacters(in: .whitespaces)
        let text2 = input2.text!.trimmingCharacters(in: .whitespaces)
        if !text.isEmpty {
            inputResult.text = text + " - " + text2
            input.text = ""
            input2.text = ""
            /*input.placeholder = "Text Field is Disabled"
            input.isEnabled = false*/
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //idetifying text field with tags
        var max = 0
        if textField.tag == 1{
            max = 10
        }else {
            max = 15
        }
        
        if textField.tag == 1 {
            ///allow 10 places of input
            if let text = textField.text {
                let total = text.count + string.count - range.length
                if total>max {
                    return false
                }
            }
            return true
        }else if textField.tag == 2{
            print(textField.tag)
            //allow 15 numbers only
            if let text = textField.text {
                let total = text.count + string.count - range.length
                if total>max {
                    return false
                }
            }
            if Int(string) != nil && textField.text != "0" || string == "" {
                return true
            }
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        assignTitleToLabel()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.systemGray2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //when focus looses
        textField.backgroundColor = UIColor.white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        input.delegate = self
        input2.delegate = self
        
        input.placeholder = "Insert Title"
        input.borderStyle = .roundedRect
        input.autocapitalizationType = .words
        
        input2.placeholder = "Insert Subtitle"
        input2.borderStyle = .roundedRect
        input2.autocapitalizationType = .words
        ///password texrt field
        input2.isSecureTextEntry = true
        
        stepper.value = 0.0
        stepper.minimumValue = 0.0
        stepper.maximumValue = 10.0
        stepper.tintColor = .purple
        //stepper.wraps = true
        
        slider.minimumValue = 0.0
        slider.maximumValue = 10.0
        slider.value = 0.0
        
        slider.minimumTrackTintColor = UIColor.systemPurple
        slider.maximumTrackTintColor = UIColor.systemYellow
        //slider.maximumValueImage = UIImage(systemName: "Book")
        
        switchLabel.text = "Switch in On"
        mySwitch.onTintColor = UIColor(red: 0.5, green: 0.9, blue: 1.0, alpha: 1.0)
        mySwitch.thumbTintColor = UIColor(red: 0.5, green: 0.5, blue: 1.0, alpha: 1.0)
        
        uiSegementControl.setAction(UIAction(title: "Purple", image: nil, handler: { action in
            print("red btn is pressed")
        }), forSegmentAt: 0)
        
        uiSegementControl.setAction(UIAction(title: "Red", handler: { action in
            print("purple btn is pressed")
        }), forSegmentAt: 1)
        
        let total = uiSegementControl.numberOfSegments
        uiSegementControl.insertSegment(action: UIAction(title: "Blue",image:nil ,handler: { action in
            print("blue btn is pressed")
        }), at: total, animated: false)
        
        uiSegementControl.insertSegment(action: UIAction(title: "Green",image:nil ,handler: { action in
            print("Green btn is pressed")
        }), at: total, animated: false)
        
        uiSegementControl.setEnabled(false, forSegmentAt: 3)
        
        turnActivityStatusBtn.changesSelectionAsPrimaryAction = true
        activity.color = UIColor.systemRed
        
        progressBar.progress = 0.2
        progressBar.tintColor = .systemPurple
        progressBar.trackTintColor = .systemYellow
        
    }
    
    /*@IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var myContextMenuBtn: UIButton!
    
    @IBOutlet weak var resetBtn: UIButton!
    
    var counter:Int = 0
    
    
    @IBAction func processOptions(_ sender: UIButton) {
        /*if let action = myContextMenuBtn.menu?.selectedElements.first as? UIAction {
            print(action.title)
        }*/
        let action = myContextMenuBtn.menu?.children[1] as? UIAction
        action?.state = .on
    }*/
    /*@IBAction func turnOnAndOff(_ sender: UIButton) {
        if sender.isSelected {
            username.text = "Is On"
        }else{
            username.text = "Is Off"
        }
    }*/
    
    /*func selectOption(action:UIAction){
        switch action.identifier.rawValue {
        case "1":
            print("option1")
            break
        case "2":
            print("option2")
            break
        case "3":
            print("option3")
            break
        default:
            print("default")
        }
    }*/
    
    /*override func viewDidLoad() {
        super.viewDidLoad()
        
        /*myContextMenuBtn.showsMenuAsPrimaryAction = true
        myContextMenuBtn.changesSelectionAsPrimaryAction = true
        myContextMenuBtn.menu = UIMenu(title:"Movie Roles",children: [
            UIAction(title: "Option1", identifier: UIAction.Identifier("1"), handler: selectOption),
            UIAction(title: "Option2", identifier: UIAction.Identifier("2"), state: .on,  handler: selectOption),
            UIAction(title: "Option3", identifier: UIAction.Identifier("3"), handler: selectOption)
        ])
        */
        //myButton.changesSelectionAsPrimaryAction = true
        //myButton.isSelected = false
        
        /*myButton.addAction(UIAction(title:"Press me",handler: { [unowned self] action in
            print("btn is pressed \(action)")
            //myButton.isEnabled = false
        }), for: .touchUpInside)*/
        
        /*var btnConfig = UIButton.Configuration.filled()
        btnConfig.title = "Press Me"
        btnConfig.subtitle = "Do it now!"
        btnConfig.baseBackgroundColor = .systemBrown
        btnConfig.cornerStyle = .capsule
        
        let myBtn = UIButton(configuration: btnConfig, primaryAction: UIAction(handler: { [unowned self] action in
            print("value of counter is : \(counter)")
            counter += 1
        }))
        
        myBtn.frame = CGRect(x: 123, y: 270, width: 150, height: 50)
        view.addSubview(myBtn)*/
        
        /*addButton.configurationUpdateHandler = { [unowned self] button in
            var configuration = button.configuration
            configuration?.title = "Add me"
            configuration?.subtitle = ""
            configuration?.showsActivityIndicator = counter > 0 ? true : false
            configuration?.imagePlacement = .trailing
            configuration?.imagePadding = 15
            button.configuration = configuration
        }*/
        // Do any additional setup after loading the view.
        
        //view.backgroundColor = .systemBlue
//        username.text = "Hello Suman, welecome to UIKIT"
//        username.numberOfLines = 1
//        username.lineBreakMode = .byCharWrapping
//        username.shadowColor = UIColor.darkGray
//        username.adjustsFontSizeToFitWidth = true
//        
//        let dynamicFont = UIFont.preferredFont(forTextStyle: .body)
//        let myFont = UIFont(name: "Georgia-Italic", size: 30)
//        let myFont2 = UIFont.systemFont(ofSize: 30)
//        let myFont3 = UIFont.systemFont(ofSize:UIFont.buttonFontSize)
//        username.font = myFont2
//        password.font = myFont3
//        password.shadowColor = UIColor.systemBlue
//        password.shadowOffset = CGSize(width: 2, height:2)
        
        var myText = AttributedString("Hello World!")
        //myText.font = UIFont.systemFont(ofSize: 24)
        //myText.backgroundColor = UIColor.gray
        //myText.foregroundColor = UIColor.systemRed
        
//        let startIndex = myText.characters.startIndex
//        let endIndex = myText.characters.index(startIndex,offsetBy: 3)
//        
//        
//        if let range = myText.range(of: "World") {
//            myText[range].font = UIFont.systemFont(ofSize: 20)
//            myText[range].foregroundColor = UIColor.systemBlue
//        }
//        
//        myText[startIndex...endIndex].font = UIFont.systemFont(ofSize: 35)
//        myText[startIndex...endIndex].foregroundColor = UIColor.systemCyan
        
//        var container = AttributeContainer()
//        container.font = UIFont.preferredFont(forTextStyle: .title1)
//        
//        let shadow = NSShadow()
//        shadow.shadowColor = UIColor.systemGray
//        shadow.shadowOffset = CGSize(width: 2, height: 2)
//        shadow.shadowBlurRadius = 5
//        
//        container.shadow = shadow
//        
//        myText.setAttributes(container)
        
//        if let range = myText.range(of: "World"){
//            myText[range].backgroundColor = UIColor.systemRed
//        }
//        
//        for run in myText.runs {
//            if run.attributes.backgroundColor == UIColor.systemRed{
//                let range = run.range
//                myText[range].backgroundColor = UIColor.systemGray4
//            }
//        }
//        
//        password.attributedText = NSAttributedString(myText)
        
        let app = UIApplication.shared
        let mydelegate = app.delegate as! AppDelegate
        
        if let salary = mydelegate.basicSalary {
            print("Basic salary : \(salary)")
        }
    }*/


}

