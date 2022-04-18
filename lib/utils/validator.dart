import 'utils.dart';

class Validator {
    static bool isEGPhoneNumber(String phone) {
        if (phone == null || phone.isEmpty) {
            return false;
        }

        final RegExp exp = RegExp(Constants.EG_PHONE_REGEX);
        return exp.hasMatch(phone);
    }

    static bool isEmail(String email) {
        if (email == null || email.isEmpty) {
            return false;
        }

        final RegExp exp = RegExp(Constants.EMAIL_REGEX);
        return exp.hasMatch(email);
    }

    static bool isVerificationCode(String code) {
        return code.length == 6;
    }

    static bool isNationalId(String code) {
        return code.length == 14;
    }

    static bool isName(String name) {
        return name.length > 3;
    }

    static bool isPassword(String password) {
        return password.length > 7;
    }

    static bool isCodeCorrect(String codeFromUser, String correctCode) {
        if (!Validator.isVerificationCode(codeFromUser)) {
            return false;
        }

        final String codeFromUserReversed = codeFromUser.split('').reversed.join();

        if (codeFromUser == correctCode || codeFromUserReversed == correctCode) {
            return true;
        }

        return false;
    }
}