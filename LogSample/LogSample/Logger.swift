//
//  Logger.swift
//

import UIKit
import os.log

/// ロガークラス
class Logger: NSObject {
    
    //
    // MARK: - Enum
    //
    // ログレベル定義
    enum LogLevel: String {
        case info = "INFO"
        case debug = "DEBUG"
        case error = "ERROR"
        case fault = "FAULT"
        case `default` = "DEFAULT"
    }
    
    //
    // MARK: - Singleton Implementation
    //
    // シングルトンインスタンス
    static let shared = Logger()
    
    /// イニシャライザ
    override private init() {
    }
    
    //
    // MARK: - Public(I/F)
    //
    
    /// printによるデバッグログ出力
    ///
    /// - Parameters:
    ///   - category: カテゴリ(任意文字列/タグ)
    ///   - message: メッセージ
    public func debugLog(category: String, message: String) {
        #if DEBUG   // デバッグビルド時
            print(self.LogTimeStamp() + " " + self.categoryStringFrom(category: category) + message)
        #endif
    }
    
    /// Infoレベルログ出力
    ///
    /// - Parameters:
    ///   - category: カテゴリ(任意文字列/タグ)
    ///   - message: メッセージ
    ///   - debugModeOnly: ログ出力をデバッグモード時に限定するかどうか
    public func info(category: String, message: StaticString, debugModeOnly: Bool) {
        if(debugModeOnly) {
            self.writeDebugLog(category: category, message: message, logLevel: LogLevel.info)
        } else {
            self.writeLog(category: category, message: message, logLevel: LogLevel.info)
        }
    }
    
    /// Debugレベルログ出力
    ///
    /// - Parameters:
    ///   - category: カテゴリ(任意文字列/タグ)
    ///   - message: メッセージ
    ///   - debugModeOnly: ログ出力をデバッグモード時に限定するかどうか
    public func debug(category: String, message: StaticString, debugModeOnly: Bool) {
        if(debugModeOnly) {
            self.writeDebugLog(category: category, message: message, logLevel: LogLevel.debug)
        } else {
            self.writeLog(category: category, message: message, logLevel: LogLevel.debug)
        }
    }
    
    /// Errorレベルログ出力
    ///
    /// - Parameters:
    ///   - category: カテゴリ(任意文字列/タグ)
    ///   - message: メッセージ
    ///   - debugModeOnly: ログ出力をデバッグモード時に限定するかどうか
    public func error(category: String, message: StaticString, debugModeOnly: Bool) {
        if(debugModeOnly) {
            self.writeDebugLog(category: category, message: message, logLevel: LogLevel.error)
        } else {
            self.writeLog(category: category, message: message, logLevel: LogLevel.error)
        }
    }
    
    /// Faultレベルログ出力
    ///
    /// - Parameters:
    ///   - category: カテゴリ(任意文字列/タグ)
    ///   - message: メッセージ
    ///   - debugModeOnly: ログ出力をデバッグモード時に限定するかどうか
    public func fault(category: String, message: StaticString, debugModeOnly: Bool) {
        if(debugModeOnly) {
            self.writeDebugLog(category: category, message: message, logLevel: LogLevel.fault)
        } else {
            self.writeLog(category: category, message: message, logLevel: LogLevel.fault)
        }
    }
    
    /// Defaultレベルログ出力
    ///
    /// - Parameters:
    ///   - category: カテゴリ(任意文字列/タグ)
    ///   - message: メッセージ
    ///   - debugModeOnly: ログ出力をデバッグモード時に限定するかどうか
    public func `default`(category: String, message: StaticString, debugModeOnly: Bool) {
        if(debugModeOnly) {
            self.writeDebugLog(category: category, message: message, logLevel: LogLevel.default)
        } else {
            self.writeLog(category: category, message: message, logLevel: LogLevel.default)
        }
    }
    
    //
    // MARK: - Private
    //
    
    /// ログレベルからOSLogTypeを取得
    ///
    /// - Parameter logLevel: ログレベル
    /// - Returns: OSLogType
    @available(iOS 10.0, *)
    private func OSLogTypeFrom(logLevel: LogLevel) -> OSLogType {
        switch logLevel {
        case LogLevel.info:
            return OSLogType.info
        case LogLevel.debug:
            return OSLogType.debug
        case LogLevel.error:
            return OSLogType.error
        case LogLevel.fault:
            return OSLogType.fault
        case LogLevel.default:
            return OSLogType.default
        }
    }
    
    /// ログ出力用タイムスタンプ取得
    ///
    /// - Returns: ログ出力用タイムスタンプ文字列
    private func LogTimeStamp() -> String {
        let now = Date.init()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS   Z"
        
        return df.string(from: now)
    }
    
    /// ログ出力用カテゴリ文字列の取得
    /// (OSLog以外を使用する場合)
    ///
    /// - Parameter category: カテゴリ(任意文字列/タグ)
    /// - Returns: ログ出力用カテゴリ文字列
    private func categoryStringFrom(category: String) -> String {
        return "[" + category + "]" + " "
    }
    
    /// ログ出力用ログ種別文字列の取得
    ///
    /// - Parameter logLevel: ログレベル
    /// - Returns: ログ出力用ログ種別文字列
    private func logTypeStringFrom(logLevel: LogLevel) -> String {
        return "[" + logLevel.rawValue + "]"
    }
    
    /// ログ出力(デバッグビルド時のみ)
    ///
    /// - Parameters:
    ///   - category: カテゴリ(任意文字列/タグ)
    ///   - message: メッセージ
    ///   - logLevel: ログレベル
    private func writeDebugLog(category: String, message: StaticString, logLevel: LogLevel) {
        #if DEBUG   // デバッグビルド時
            self.writeLog(category: category, message: message, logLevel: logLevel)
        #endif
    }
    
    /// ログ出力
    ///
    /// - Parameters:
    ///   - category: カテゴリ(任意文字列/タグ)
    ///   - message: メッセージ
    ///   - logLevel: ログレベル
    private func writeLog(category: String, message: StaticString, logLevel: LogLevel) {
        if #available(iOS 10.0, *) {    // iOS10以降
            // OSログ設定
            let osLog: OSLog
            if let bundleId = Bundle.main.bundleIdentifier {
                osLog = OSLog(subsystem: bundleId, category: category)
            } else {
                osLog = OSLog(subsystem: "", category: category)
            }
            
            // ログタイプ取得
            let logType = self.OSLogTypeFrom(logLevel: logLevel)
            
            // os_logでログ出力
            os_log(message, log: osLog, type: logType)
        } else {    // iOS9以前
            // メッセージにカテゴリを付加
            let logMessage = self.categoryStringFrom(category: category) + self.logTypeStringFrom(logLevel: logLevel) + message.description
            
            // NSLogでログ出力
            NSLog(logMessage)
        }
    }
}
