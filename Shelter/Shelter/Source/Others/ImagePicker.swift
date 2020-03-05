
import SwiftUI

struct ImagePicker:UIViewControllerRepresentable {
    
    @Binding var originalImage:UIImage?
    @Binding var presentationMode:Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        Coordinator(imagePicker: self)
    }
    
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        
        var picker:ImagePicker
        
        init(imagePicker:ImagePicker) {
            self.picker = imagePicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else {
                return
            }
            self.picker.originalImage = image
            self.picker.presentationMode = false
        }
    }
}
