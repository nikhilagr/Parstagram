//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Nikhil Agrawal on 06/03/19.
//  Copyright © 2019 Nikhil Agrawal. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse


class CameraViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        
        let post = PFObject(className: "Posts")
        
        // defining Schema for post
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        
        //PfObject support many default type and also binary objects like photo
        //binary objects are not directly stored in row but they are stored as URL
        // create a PFFileObject to store the binary and then store that file in post table
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("Post saved succesfully")
            }else{
                print("Error in saving post")
            }
        }
        
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        // check if the camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
            // use the photo library
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    // once the picker is set we need to show the image in the image view
    // To do this we need to implement a function imagePickerController
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage// get image from dictionary named info
        // resizing the image to support Heroku
        let size = CGSize(width:300, height:300)
        let scaledImage = image.af_imageScaled(to:size)
        imageView.image = scaledImage
        
        // dismiss the camera view once the image is loaded in the imageview
        dismiss(animated: true, completion: nil)
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
