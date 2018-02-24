//
//  CreateTaskViewController.swift
//  Doing
//
//  Created by rotem nevgauker on 1/28/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import UIKit

extension CreateTaskViewController:UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CompletionDate.all[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        createViewModel.completionDateString = CompletionDate.all[row]
        createViewModel.didChangeCompletionDateString = (createViewControllerState == CreateViewControllerState.update)
    }
    
}


extension CreateTaskViewController:UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CompletionDate.count
    }
   
    
}

extension CreateTaskViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.text.becomeFirstResponder()
        return true
    }
    
    
}

extension CreateTaskViewController:UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        createViewModel.text = textView.text
        createViewModel.didChangeText = (createViewControllerState == CreateViewControllerState.update)
        
        
    }
}

extension CreateTaskViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasksColors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:ColorCellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCellCollectionViewCell", for: indexPath) as! ColorCellCollectionViewCell
        
        
        var frame = cell.colorView.frame
        
    
        frame.size.width = cell.frame.size.width - 5
        frame.size.height = cell.frame.size.height - 5
        cell.colorView.frame = frame
//        cell.colorView.center = cell.center
        cell.colorView.backgroundColor = tasksColors[indexPath.row]
        cell.colorView.layer.cornerRadius = cell.colorView.frame.size.width / 2.0
        return cell
        
        
    }
}

extension CreateTaskViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        createViewModel.didSelectColor(index:indexPath.item)
        colorBtn.backgroundColor = UIColor(hexString: createViewModel.selectedColorStr)
        createViewModel.didChangeColor = true
        didPressColorBtn(UIButton())
    }
    
}


extension CreateTaskViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        
        let size = CGSize(width: collectionView.frame.size.width / 3, height: collectionView.frame.size.height / 3)
        return size
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0 
    }
    
}


class CreateTaskViewController: UIViewController {

    @IBOutlet weak var fiveWordsTitle: UITextField!
    @IBOutlet var createViewModel:CreateViewModel!
    
    @IBOutlet weak var CompletionDatePicker: UIPickerView!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var addOrUpdateBtn: UIButton!
    @IBOutlet weak var canceleBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    
    @IBOutlet weak var colorBtn: UIButton!
    
    @IBOutlet weak var topRightlabel: UILabel!
    @IBOutlet weak var midRightLabel: UILabel!


    
    
    var createViewControllerState:CreateViewControllerState = CreateViewControllerState.create

    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        text.delegate = self
        setGUI()
        setDataIfNeeded()
        
        if createViewControllerState == CreateViewControllerState.update {
            
            self.addOrUpdateBtn.setTitle("Update", for: .normal)
            
            
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print(self.addOrUpdateBtn.frame)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: setup
    func setGUI(){
        fiveWordsTitle.autocorrectionType = .no
        text.autocorrectionType = .no
        containerView.layer.cornerRadius = 10.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize.zero
        addOrUpdateBtn.layer.cornerRadius = addOrUpdateBtn.frame.size.width/2
        addOrUpdateBtn.layer.shadowColor = UIColor.black.cgColor
        addOrUpdateBtn.layer.shadowOpacity = 0.4
        addOrUpdateBtn.layer.shadowOffset = CGSize.zero
        canceleBtn.layer.cornerRadius = canceleBtn.frame.size.width/2
        canceleBtn.layer.cornerRadius = addOrUpdateBtn.frame.size.width/2
        canceleBtn.layer.shadowColor = UIColor.black.cgColor
        canceleBtn.layer.shadowOpacity = 0.4
        canceleBtn.layer.shadowOffset = CGSize.zero
        CompletionDatePicker.layer.cornerRadius = 10.0
        text.layer.cornerRadius = 10.0
        fiveWordsTitle.layer.cornerRadius = 10.0
        colorsCollectionView.layer.cornerRadius = 10.0
        colorBtn.layer.cornerRadius = 10.0
        colorsCollectionView.alpha = 0
        colorBtn.backgroundColor =  UIColor(hexString: createViewModel.selectedColorStr)
    }
    
    //MARK: actions
     @IBAction func didPressColorBtn(_ sender: Any) {
        
        UIView.animate(withDuration:0.4, animations: {
            
            if self.colorsCollectionView.alpha == 1.0 {
                self.colorsCollectionView.alpha = 0
            }else{
                self.colorsCollectionView.alpha = 1.0
            }
            if self.colorsCollectionView.alpha == 1.0 {
                self.topRightlabel.alpha = 0
                self.midRightLabel.text = "Select a color"
            }else {
                self.topRightlabel.alpha = 1.0
                self.midRightLabel.text = "Date"
            }
        }, completion: nil)
    }
    @IBAction func didPressCancelBtn(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func didPressAddBtn(_ sender: Any) {
        
        if createViewControllerState == CreateViewControllerState.create {
            createViewModel.createTask(){
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }else {
        
            let  fiveWordsTitle = self.fiveWordsTitle.text
            let text = self.text.text
            let index = CompletionDatePicker.selectedRow(inComponent: 0)
            let all = CompletionDate.all
            let completionDateString = all[index]
            createViewModel.updatIfNeeded(fiveWordsTitle: fiveWordsTitle!, text: text!, completionDateString: completionDateString, completion: {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
            })
        }
    }

    @IBAction func didEditFiveWordsTitle(_ sender: UITextField) {
        createViewModel.fiveWordsTitle = sender.text
        createViewModel.didChangeFiveWordsTitle = (createViewControllerState == CreateViewControllerState.update)
    }
    
    
    func setDataIfNeeded() {
        
        if let titleValue = createViewModel.fiveWordsTitle {
            self.fiveWordsTitle.text = titleValue
        }
        
        if let textValue = createViewModel.text {
            self.text.text = textValue
        }
        
        let color = UIColor(hexString: createViewModel.selectedColorStr)
        self.colorBtn.backgroundColor = color
        
        let arr = CompletionDate.all
        let index = arr.index(of: createViewModel.completionDateString)
        CompletionDatePicker.selectRow(index!, inComponent: 0, animated: false)
        
        
        
        
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.view.frame.size.height + keyboardHeight)
        }
    }
}
