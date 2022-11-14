import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:signal/constance/styles.dart';
import 'colors.dart';
import 'icon_broken.dart';

// class LanguageModel {
//   final String language;
//   final String code;
//
//   LanguageModel({
//     this.language,
//     this.code,
//   });
// }
//
// List<LanguageModel> languageList = [
//   LanguageModel(
//     language: 'English',
//     code: 'en',
//   ),
//   LanguageModel(
//     language: 'العربية',
//     code: 'ar',
//   ),
// ];
//
// Widget languageItem(
//   LanguageModel model, {
//   context,
//   index,
// }) =>
//     InkWell(
//       onTap: () {
//         AppCubit.get(context).changeSelectedLanguage(index);
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 model.language,
//               ),
//             ),
//             if (AppCubit.get(context).selectedLanguage[index])
//               Icon(
//                 IconBroken.Arrow___Right_Circle,
//               ),
//           ],
//         ),
//       ),
//     );

Widget defaultSeparator() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

Widget defaultButton({
  required  function,
  required String text,
}) =>
    Container(
      height: 40.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.myPrimary,
        borderRadius: BorderRadius.circular(
          3.0,
        ),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: white14bold(),
        ),
      ),
    );

void showToast({
  required String? text,
  required ToastColors color,
}) {
   Fluttertoast.showToast(
    msg: text!,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: setToastColor(color),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastColors {
  SUCCESS,
  ERROR,
  WARNING,
}

Color setToastColor(ToastColors color) {
  Color c;

  switch (color) {
    case ToastColors.ERROR:
      c = Colors.red;
      break;
    case ToastColors.SUCCESS:
      c = Colors.green;
      break;
    case ToastColors.WARNING:
      c = Colors.amber;
      break;
  }

  return c;
}

void navigateTo({context, widget}) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish({context, widget}) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

Widget defaultFormField(
    context, {
      required TextEditingController controller,
      required TextInputType type,
      String? Function(String?)? onSubmit,
      String? Function(String?)? onChange,
      Function()? onTap,
      bool isPassword = false,
      required String? Function(String?)? validate,
      String? label,
      String? hint,
      Color? bodercolor,
      IconData? prefix,
      IconData? suffix,
      int maxlines = 1,
      double hintsize = 14.0,
      double verticalpadding = 13.0,
      double horizontalpadding = 15.0,
      Color borderEnableColor = Colors.blue,
      Color borderColor = Colors.grey,
      Function()? suffixPressed,
      bool isClickable = true,
    }) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
            color: Colors.grey,
          ),
        )
            : null,
      ),
      style: Theme.of(context).textTheme.bodyText1,
    );

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    height: 1.0,
    width: double.infinity,
    color: Colors.grey,
  ),
);
PreferredSizeWidget defaultAppBar(
    {String? title,
      List<Widget>? actions,
      required BuildContext context}) =>
    AppBar(
      titleSpacing: 5.0,
      title: Text(title ?? ''),
      actions: actions,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(IconBroken.Arrow___Left_2)),
    );
