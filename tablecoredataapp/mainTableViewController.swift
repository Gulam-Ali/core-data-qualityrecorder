//
//  mainTableViewController.swift
//  tablecoredataapp
//
//  Created by gulam ali on 15/09/17.
//  Copyright © 2017 gulam ali. All rights reserved.
//

import UIKit
import CoreData


class mainTableViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
   // var myinfo = [["name" : "Dad","image":"scene1","item":"Down to earth nature"],["name":"Mom","image":"scene2","item":"Amazing personality"],["name":"Brother","image":"scene3","item":"Cool guy"],["name":"Sister","image":"scene4","item":"Cute lil girl"],["name":"Friend","image":"scene5","item":"All are bruh"]]
    
    var newdata = [Qualities]()

   var manageobjex = NSManagedObjectContext()
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         let iconimageview = UIImageView(image: UIImage(named :"cam"))
       
        iconimageview.frame = CGRect(x: 0, y: 0, width: 34, height: 34) // setting frames for image
       iconimageview.contentMode = .scaleAspectFit // for setting aspect ratio of pic
       
        
        self.navigationItem.titleView = iconimageview  // dese two lines are used to place the icon image in centre of navibar.
        
        
       
        
        
        manageobjex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        loaddata()
    }
    
    
    func loaddata()  {
        let qualityrequest:NSFetchRequest<Qualities> = Qualities.fetchRequest() // fetching data from database 
        do{
            
        newdata = try manageobjex.fetch(qualityrequest)
        self.tableView.reloadData()
            
            
        }
        
        
        catch{
            print("could not load data from database")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    } // this func is used to create a certain height of row

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 // if u return more than 1 it will copy the content moredn one..dts y we write 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newdata.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! presenceTableViewCell


        let newdataobject = newdata[indexPath.row]
        
        if let newdataimage = UIImage(data: newdataobject.personimage! as Data){
        
            cell.bgimage.image = newdataimage

        
        }
                cell.name.text = newdataobject.personname
        cell.item.text = newdataobject.personquality
        
                return cell
    }
    
    
   @IBAction func pickimage(_ sender: Any) {
        
        let imagepicker = UIImagePickerController()
        
        imagepicker.sourceType = .photoLibrary // coz we are only using photo libraray
        imagepicker.delegate = self // coz we are accesing the delegate func of image picker by self
        self.present(imagepicker, animated: true, completion: nil)
        
    }
    
   func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    
    
    picker.dismiss(animated: true, completion: nil)  // dis line wil cancel the selecting pic = cancels the pickerview controller
    
   }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage]as?UIImage {
        
            picker.dismiss(animated: true, completion: {self.createqualityitem(withimage :image)})
    }
    

  
}
    func createqualityitem (withimage: UIImage)   {
    
    
       let qualityitem = Qualities(context: manageobjex)
        
        qualityitem.personimage = NSData(data : UIImageJPEGRepresentation(withimage, 0.3)!) as Data
   
        let alert = UIAlertController(title: "fill it", message: "Enter name and quality", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "person"
            
        }
        
            alert.addTextField { (textField) in
                textField.placeholder = "quality"
                
        }
        
        alert.addAction(UIAlertAction(title: "save", style: .default, handler: {(action:UIAlertAction) in
        
       
            
            let persontextfield = alert.textFields?.first   // gettin user text and assign to object
            
            let qualitytextfield = alert.textFields?.last
            
            if persontextfield?.text != "" && qualitytextfield?.text != "" {
                
                // below two lines are storing the user text into the qualityitem wich is object of Qualities (database name) and assigning the text on attributes which are person name and person quality
                
                qualityitem.personname = persontextfield?.text
                qualityitem.personquality = qualitytextfield?.text
                
                do {
                    try self.manageobjex.save()
                    self.loaddata() // last line of code into da app in orderr to load tha data which is saved into the database.
                }
                catch{
                    print("could not save data")
                }
                
            }
    
        }))
        
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    
    }
    
    
    
    
}

















