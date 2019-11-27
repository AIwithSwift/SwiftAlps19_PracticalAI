//
//  ContentView.swift
//  FDDemo
//
//  Created by Mars Geldard on 20/6/19.
//  Copyright © 2019 Mars Geldard. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var imagePickerOpen: Bool = false
    @State private var cameraOpen: Bool = false
    @State private var image: UIImage? = nil
    @State private var faces: [Any]? = nil
    // TODO: store face detections so that changes update view
    
    private var faceCount: Int { return faces?.count ?? 0 }
    private let placeholderImage = UIImage(named: "placeholder")!
    private var cameraEnabled: Bool { UIImagePickerController.isSourceTypeAvailable(.camera) }
    private var detectionEnabled: Bool { image != nil && faces == nil }
    
    var body: some View {
        if imagePickerOpen { return imagePickerView() }
        if cameraOpen { return cameraView() }
        return mainView()
    }
    
    private func getFaces() {
        print("Getting faces...")
        self.faces = []
        
        // TODO: get and annotate faces
    }
    
    private func controlReturned(image: UIImage?) {
        print("Image return \(image == nil ? "failure" : "success")...")
        self.image = image?.fixOrientation()
        self.faces = nil
    }
    
    private func summonImagePicker() {
        print("Summoning ImagePicker...")
        imagePickerOpen = true
    }
    
    private func summonCamera() {
        print("Summoning camera...")
        cameraOpen = true
    }
}

extension ContentView {
    private func mainView() -> AnyView {
        return AnyView(NavigationView {
            MainView(image: image ?? placeholderImage, text: "\(faceCount) face\(faceCount == 1 ? "" : "s")") {
                TwoStateButton(text: "Detect Faces", disabled: !detectionEnabled, action: getFaces)
            }.padding().navigationBarTitle(Text("FDDemo"), displayMode: .inline)
            .navigationBarItems(leading: Button(action: summonImagePicker) { Text("Select") },
                                trailing: Button(action: summonCamera) { Image(systemName: "camera") }.disabled(!cameraEnabled))
        })
    }
    
    private func imagePickerView() -> AnyView {
        return  AnyView(ImagePicker { result in
            self.controlReturned(image: result)
            self.imagePickerOpen = false
        })
    }
    
    private func cameraView() -> AnyView {
        return  AnyView(ImagePicker(camera: true) { result in
            self.controlReturned(image: result)
            self.cameraOpen = false
        })
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
