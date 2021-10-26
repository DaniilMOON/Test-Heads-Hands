// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Plural format key: "%#@VARIABLE@"
  internal static func ageValue(_ p1: Int) -> String {
    return L10n.tr("Localizable", "age-value", p1)
  }

  internal enum Auth {
    /// Войти
    internal static let action = L10n.tr("Localizable", "auth.action")
    /// Логин
    internal static let login = L10n.tr("Localizable", "auth.login")
    /// Пароль
    internal static let password = L10n.tr("Localizable", "auth.password")
  }

  internal enum Catalog {
    /// Купить
    internal static let buy = L10n.tr("Localizable", "catalog.buy")
    /// Каталог
    internal static let title = L10n.tr("Localizable", "catalog.title")
  }

  internal enum Common {
    /// Поле пустое
    internal static let emptyField = L10n.tr("Localizable", "common.emptyField")
    /// Что-то пошло не так
    internal static let error = L10n.tr("Localizable", "common.error")
  }

  internal enum DetalInfoProduct {
    /// Назад
    internal static let back = L10n.tr("Localizable", "detalInfoProduct.back")
    /// Купить сейчас
    internal static let buyNow = L10n.tr("Localizable", "detalInfoProduct.buyNow")
  }

  internal enum History {
    internal enum DeleteOrder {
      /// Вы точно хотите отменить заказ?
      internal static let answer = L10n.tr("Localizable", "history.deleteOrder.answer")
      /// Нет
      internal static let no = L10n.tr("Localizable", "history.deleteOrder.no")
      /// Да
      internal static let yes = L10n.tr("Localizable", "history.deleteOrder.yes")
    }
    internal enum SegmentedControl {
      /// АКТИВНЫЕ
      internal static let active = L10n.tr("Localizable", "history.segmentedControl.active")
      /// ВСЕ
      internal static let all = L10n.tr("Localizable", "history.segmentedControl.all")
    }
  }

  internal enum OrderForm {
    /// Дом
    internal static let address = L10n.tr("Localizable", "orderForm.address")
    /// Купить за
    internal static let buyNow = L10n.tr("Localizable", "orderForm.buyNow")
    /// Дата доставки
    internal static let deliveryDate = L10n.tr("Localizable", "orderForm.deliveryDate")
    /// Квартира
    internal static let flatNumber = L10n.tr("Localizable", "orderForm.flatNumber")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
