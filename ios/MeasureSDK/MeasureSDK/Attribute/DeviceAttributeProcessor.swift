//
//  DeviceAttributeProcessor.swift
//  MeasureSDK
//
//  Created by Adwin Ross on 03/09/24.
//

import Foundation
import UIKit

/// Generates the device attributes such as device name, model, manufacturer, and more. These attributes are expected to be constant during the session and are computed once.
final class DeviceAttributeProcessor: BaseComputeOnceAttributeProcessor {
    private lazy var deviceName = UIDevice.current.name
    private lazy var deviceModel = UIDevice.modelName
    private lazy var deviceManufacturer = AttributeConstants.deviceManufacturer
    private lazy var deviceType = UIDevice.current.userInterfaceIdiom == .phone ? AttributeConstants.phone : AttributeConstants.tablet
    private lazy var deviceIsFoldable = false
    private lazy var deviceIsPhysical = TARGET_OS_SIMULATOR == 0
    private lazy var deviceDensityDpi = Int64(UIScreen.main.scale * 160)
    private lazy var deviceWidthPx = Int64(UIScreen.main.bounds.width * UIScreen.main.scale)
    private lazy var deviceHeightPx = Int64(UIScreen.main.bounds.height * UIScreen.main.scale)
    private lazy var deviceDensity = Int64(UIScreen.main.scale)
    private lazy var deviceLocale = Locale.current.identifier
    private lazy var osName = UIDevice.current.systemName
    private lazy var osVersion = UIDevice.current.systemVersion
    private lazy var platform = AttributeConstants.platform

    override func computeAttributes() -> [String: Any?] {
        return [Attribute.deviceName: deviceName,
                Attribute.deviceModel: deviceModel,
                Attribute.deviceManufacturer: deviceManufacturer,
                Attribute.deviceType: deviceType,
                Attribute.deviceIsFoldable: deviceIsFoldable,
                Attribute.deviceIsPhysical: deviceIsPhysical,
                Attribute.deviceDensityDpi: deviceDensityDpi,
                Attribute.deviceWidthPx: deviceWidthPx,
                Attribute.deviceHeightPx: deviceHeightPx,
                Attribute.deviceDensity: deviceDensity,
                Attribute.deviceLocale: deviceLocale,
                Attribute.osName: osName,
                Attribute.osVersion: osVersion,
                Attribute.platform: platform,
                Attribute.deviceCpuArch: getCPUArchitecture()]
    }

    func getCPUArchitecture() -> String {
        var sysInfo = utsname()
        uname(&sysInfo)

        let machineMirror = Mirror(reflecting: sysInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        return identifier
    }
}
