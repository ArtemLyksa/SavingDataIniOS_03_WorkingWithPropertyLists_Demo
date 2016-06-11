import UIKit

let plistURL = NSBundle.mainBundle().URLForResource("Books", withExtension: "plist")
let filemanager = NSFileManager.defaultManager()

if let plistData = NSData(contentsOfURL: plistURL!) {
    var format = NSPropertyListFormat.XMLFormat_v1_0
    do {
        let books = try NSPropertyListSerialization.propertyListWithData(plistData, options: .Immutable, format: &format)
        let book = books[0]
        if let name = book["Name"] {
            print(name!)
        }
        if let pageCount = book["Page Count"] {
            print(pageCount!)
        }
        if let publicationDate = book["Publication Date"] {
            print(publicationDate!)
        }
        if let thumbnail = book["Thumbnail"] {
            let data = thumbnail! as! NSData
            let image = UIImage(data: data)
        }
        
        let bookImage = UIImage(named:"TVT-PDF-640")
        let bookData = UIImagePNGRepresentation(bookImage!)
        let anotherBook = ["Name" : "tvOS by Tutorials", "Publication Date" : NSData(), "Page Count" : 694, "Thumbnail" : bookData!]
        
        let moreBooks = [book, anotherBook];
        let serializedData = try NSPropertyListSerialization.dataWithPropertyList(moreBooks, format: NSPropertyListFormat.XMLFormat_v1_0, options: 0)
        let document = try filemanager.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false)
        
        let file = document.URLByAppendingPathComponent("books.plist")
        serializedData.writeToURL(file, atomically: true)
        print(document)
    } catch {
        print(error)
    }
    
}