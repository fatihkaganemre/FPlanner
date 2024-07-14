//
//  AudioTool.swift
//  FPlanner
//
//  Created by Fatih Kagan Emre on 14/07/2024.
//

import Foundation
import AudioToolbox

struct AudioTool {
    
    static func playSytemSound() {
        //let status = AudioServicesCreateSystemSoundID(<#T##inFileURL: CFURL##CFURL#>, <#T##outSystemSoundID: UnsafeMutablePointer<SystemSoundID>##UnsafeMutablePointer<SystemSoundID>#>)
        AudioServicesPlaySystemSound(kAudioServicesPropertyIsUISound)
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
