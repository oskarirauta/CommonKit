//
//  CameraController.swift
//  CommonKit
//
//  Created by Oskari Rauta on 11/06/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//
//  Original:
//      AV Foundation
//
//      Created by Pranjal Satija on 29/5/2017.
//      Copyright © 2017 AppCoda. All rights reserved.
//

import AVFoundation
import UIKit

extension UIInterfaceOrientation {
    
    var videoOrientation: AVCaptureVideoOrientation? {
        switch self {
        case .portraitUpsideDown: return .portraitUpsideDown
        case .landscapeRight: return .landscapeRight
        case .landscapeLeft: return .landscapeLeft
        case .portrait: return .portrait
        default: return nil
        }
    }
}

open class CameraController: NSObject {
    
    open var captureSession: AVCaptureSession?
    
    open var currentCameraPosition: CameraPosition?
    
    open var frontCamera: AVCaptureDevice?
    open var frontCameraInput: AVCaptureDeviceInput?
    
    open var photoOutput: AVCapturePhotoOutput?
    
    open var rearCamera: AVCaptureDevice?
    open var rearCameraInput: AVCaptureDeviceInput?
    
    open var previewLayer: AVCaptureVideoPreviewLayer?
    
    open var flashMode = AVCaptureDevice.FlashMode.off
    open var photoCaptureCompletionBlock: ((UIImage?, Error?) -> Void)?
    
    open var currentCamera: AVCaptureDevice? {
        get {
            if ( self.currentCameraPosition == .front ) { return self.frontCamera }
            else if ( self.currentCameraPosition == .rear ) { return self.rearCamera }
            else { return nil }
        }
    }
    
    open var captureInProgress: Bool {
        get { return self._captureInProgress }
    }
    
    open var availableFlashModes: [AVCaptureDevice.FlashMode] {
        get { return self.photoOutput?.supportedFlashModes ?? [.off] }
    }
    
    open var multipleCameras: Bool {
        get { return self.rearCamera != nil && self.frontCamera != nil && self.rearCamera != self.frontCamera ? true : false }
    }
    
    open var attachedToView: Bool {
        get { return self.previewLayer?.superlayer ?? nil != nil }
    }
    
    open var hasCamera: Bool {
        get { return UIImagePickerController.isSourceTypeAvailable(.camera) }
    }
    
    fileprivate var _captureInProgress: Bool = false
    fileprivate var _contentView: UIView?
    
}

extension CameraController {
    open func prepare(completionHandler: @escaping (Error?) -> Void) {
        func createCaptureSession() {
            self.captureSession = AVCaptureSession()
        }
        
        func configureCaptureDevices() throws {
            let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
            let cameras = session.devices.compactMap { $0 }
            guard !cameras.isEmpty else { throw CameraControllerError.noCamerasAvailable }
            
            for camera in cameras {
                
                if ( camera.isFocusModeSupported(.continuousAutoFocus)) {
                    do {
                        try camera.lockForConfiguration()
                        defer { camera.unlockForConfiguration() }
                        camera.focusMode = .continuousAutoFocus
                    } catch {}
                }
                
                if camera.position == .front {
                    self.frontCamera = camera
                }
                
                if camera.position == .back {
                    self.rearCamera = camera
                }
                
            }
        }
        
        func configureDeviceInputs() throws {
            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
            
            if let rearCamera = self.rearCamera {
                self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
                
                if captureSession.canAddInput(self.rearCameraInput!) { captureSession.addInput(self.rearCameraInput!) }
                
                self.currentCameraPosition = .rear
            }
                
            else if let frontCamera = self.frontCamera {
                self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
                
                if captureSession.canAddInput(self.frontCameraInput!) { captureSession.addInput(self.frontCameraInput!) }
                else { throw CameraControllerError.inputsAreInvalid }
                
                self.currentCameraPosition = .front
            }
                
            else { throw CameraControllerError.noCamerasAvailable }
        }
        
        func configurePhotoOutput() throws {
            guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
            
            self.photoOutput = AVCapturePhotoOutput()
            self.photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
            self.photoOutput?.isHighResolutionCaptureEnabled = true
            
            guard self.photoOutput != nil else { throw CameraControllerError.invalidOperation }
            
            if captureSession.canAddOutput(self.photoOutput!) { captureSession.addOutput(self.photoOutput!) }
            captureSession.startRunning()
            
            self.flashMode = self.photoOutput!.supportedFlashModes.contains(.auto) ? .auto : .off
        }
        
        DispatchQueue(label: "prepare").async {
            do {
                createCaptureSession()
                try configureCaptureDevices()
                try configureDeviceInputs()
                try configurePhotoOutput()
            }
                
            catch {
                DispatchQueue.main.async {
                    completionHandler(error)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(nil)
            }
        }
    }
    
    @objc open func rotated() {
        
        guard self.previewLayer != nil else { return }
        
        if ( self._contentView != nil ) {
            self.previewLayer?.frame = self._contentView!.bounds
        }
        
        if ( self.previewLayer?.connection?.isVideoOrientationSupported ?? false ) {
            self.previewLayer?.connection?.videoOrientation = UIApplication.shared.statusBarOrientation.videoOrientation ?? .portrait
        }
        
    }
    
    open func stop() {
        if (( self.captureSession != nil ) && ( self.captureSession?.isRunning ?? false )) {
            self.captureSession?.stopRunning()
        }
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    open func resetCamera() {
        
        guard self.captureSession != nil,
            self.currentCameraPosition != nil,
            !self._captureInProgress,
            let device = self.currentCameraPosition! == .front ? self.frontCamera : self.rearCamera
            else { return }
        
        do {
            try device.lockForConfiguration()
            defer { device.unlockForConfiguration() }
            
            device.videoZoomFactor = 1.0
            
            if ( device.isFocusModeSupported(.continuousAutoFocus)) {
                device.focusMode = .continuousAutoFocus
            } else if ( device.isFocusModeSupported(.autoFocus)) {
                device.focusMode = .autoFocus
            } else if ( device.isFocusModeSupported(.locked)) {
                device.focusMode = .locked
            }
            
        } catch { }
        
    }
    
    open func start() {
        
        guard self.captureSession != nil else { return }
        
        self._captureInProgress = false
        
        if ( self._contentView != nil ) {
            self.previewLayer?.frame = self._contentView!.bounds
        }
        
        if ( self.previewLayer?.connection?.isVideoOrientationSupported ?? false ) {
            self.previewLayer?.connection?.videoOrientation = UIApplication.shared.statusBarOrientation.videoOrientation ?? .portrait
        }
        
        if ( !(self.captureSession?.isRunning ?? true )) {
            self.captureSession?.startRunning()
            self.resetCamera()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        
    }
    
    open func toggleFlashMode() throws {
        guard self.photoOutput != nil, self.availableFlashModes.count > 1 else { throw CameraControllerError.invalidOperation }
        
        let index = self.availableFlashModes.firstIndex(of: self.flashMode) ?? 0
        
        self.flashMode = self.availableFlashModes[ index == ( self.availableFlashModes.count - 1 ) ? 0 : ( index + 1 ) ]
    }
    
    open func displayPreview(on view: UIView) throws {
        guard let captureSession = self.captureSession, captureSession.isRunning else { throw CameraControllerError.captureSessionIsMissing }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        if ( self.previewLayer?.connection?.isVideoOrientationSupported ?? false ) {
            self.previewLayer?.connection?.videoOrientation = UIApplication.shared.statusBarOrientation.videoOrientation ?? .portrait
        }
        
        view.layer.insertSublayer(self.previewLayer!, at: 0)
        self.previewLayer?.frame = view.bounds
        self._contentView = view
    }
    
    open func removePreview() {
        guard _contentView != nil else { return }
        self.previewLayer?.removeFromSuperlayer()
        self._contentView = nil
    }
    
    open func switchCameras() throws {
        guard let currentCameraPosition = currentCameraPosition, let captureSession = self.captureSession, captureSession.isRunning else { throw CameraControllerError.captureSessionIsMissing }
        
        captureSession.beginConfiguration()
        
        func switchToFrontCamera() throws {
            let inputs = captureSession.inputs
            guard let rearCameraInput = self.rearCameraInput, inputs.contains(rearCameraInput),
                let frontCamera = self.frontCamera else { throw CameraControllerError.invalidOperation }
            
            self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
            
            captureSession.removeInput(rearCameraInput)
            
            if captureSession.canAddInput(self.frontCameraInput!) {
                captureSession.addInput(self.frontCameraInput!)
                
                self.currentCameraPosition = .front
            }
                
            else {
                throw CameraControllerError.invalidOperation
            }
        }
        
        func switchToRearCamera() throws {
            let inputs = captureSession.inputs
            guard let frontCameraInput = self.frontCameraInput, inputs.contains(frontCameraInput),
                let rearCamera = self.rearCamera else { throw CameraControllerError.invalidOperation }
            
            self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
            
            captureSession.removeInput(frontCameraInput)
            
            if captureSession.canAddInput(self.rearCameraInput!) {
                captureSession.addInput(self.rearCameraInput!)
                
                self.currentCameraPosition = .rear
            }
                
            else { throw CameraControllerError.invalidOperation }
        }
        
        switch currentCameraPosition {
        case .front:
            try switchToRearCamera()
            
        case .rear:
            try switchToFrontCamera()
        }
        
        captureSession.commitConfiguration()
        self.resetCamera()
    }
    
    open func captureImage(completion: @escaping (UIImage?, Error?) -> Void) {
        guard let captureSession = captureSession, captureSession.isRunning else { completion(nil, CameraControllerError.captureSessionIsMissing); return }
        
        self._captureInProgress = true
        
        let settings = AVCapturePhotoSettings()
        settings.flashMode = self.flashMode
        
        self.photoOutput?.capturePhoto(with: settings, delegate: self)
        self.photoCaptureCompletionBlock = completion
    }
    
}

extension CameraController: AVCapturePhotoCaptureDelegate {
    
    open func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        self._captureInProgress = false
        
        if let error = error {
            self.photoCaptureCompletionBlock?(nil, error)
            
        } else if  let imageData = photo.fileDataRepresentation() {
            let image = UIImage(data: imageData)
            self.photoCaptureCompletionBlock?(image, image != nil ? nil : CameraControllerError.unknown)
        } else {
            self.photoCaptureCompletionBlock?(nil, CameraControllerError.unknown)
        }
    }
    
}

extension CameraController {
    public enum CameraControllerError: Swift.Error {
        case captureSessionAlreadyRunning
        case captureSessionIsMissing
        case inputsAreInvalid
        case invalidOperation
        case noCamerasAvailable
        case unknown
    }
    
    public enum CameraPosition: Int {
        case front = 0
        case rear = 1
    }
}
