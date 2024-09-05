//
//  AppAttributeProcessor.swift
//  MeasureSDK
//
//  Created by Adwin Ross on 03/09/24.
//

import Foundation

/// Generates the attributes for the app. The attributes include the app version, build version, and the unique ID of the app.
final class AppAttributeProcessor: BaseComputeOnceAttributeProcessor {
    private lazy var appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? AttributeConstants.unknown
    private lazy var appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? AttributeConstants.unknown
    private lazy var appUniqueId = Bundle.main.bundleIdentifier ?? AttributeConstants.unknown
    private lazy var measureSdkVersion = FrameworkInfo.version

    override func computeAttributes() -> [String: Any?] {
        return [Attribute.appVersion: appVersion,
                Attribute.appBuild: appBuild,
                Attribute.appUniqueId: appUniqueId,
                Attribute.measureSdkVersion: measureSdkVersion]
    }
}
