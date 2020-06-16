// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "forgotPasswordLink" : MessageLookupByLibrary.simpleMessage("Forgot Password"),
    "inputPasswordHint" : MessageLookupByLibrary.simpleMessage("Please enter the password"),
    "inputPhoneHint" : MessageLookupByLibrary.simpleMessage("Please enter phone number"),
    "inputPhoneInvalid" : MessageLookupByLibrary.simpleMessage("Please input valid mobile phone number"),
    "inputUsernameHint" : MessageLookupByLibrary.simpleMessage("Please input Username"),
    "inputVerificationCodeHint" : MessageLookupByLibrary.simpleMessage("Please enter verification code"),
    "login" : MessageLookupByLibrary.simpleMessage("Login"),
    "noAccountRegisterLink" : MessageLookupByLibrary.simpleMessage("No account yet? Register now"),
    "openYourAccount" : MessageLookupByLibrary.simpleMessage("Open your account"),
    "passwordLogin" : MessageLookupByLibrary.simpleMessage("Password Login"),
    "register" : MessageLookupByLibrary.simpleMessage("Register"),
    "title" : MessageLookupByLibrary.simpleMessage("Flutter Deer"),
    "verificationButton" : MessageLookupByLibrary.simpleMessage("Not really sent, just log in!"),
    "verificationCodeLogin" : MessageLookupByLibrary.simpleMessage("Verification Code Login"),
    "getVerificationCode" : MessageLookupByLibrary.simpleMessage("Get verification code"),
    "confirm" : MessageLookupByLibrary.simpleMessage("Confirm"),
    "resetLoginPassword" : MessageLookupByLibrary.simpleMessage("Reset Login Password"),
    "registeredTips" : MessageLookupByLibrary.simpleMessage("Unregistered mobile phone number, please ")
  };
}
