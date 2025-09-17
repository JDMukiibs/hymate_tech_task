// import 'package:flutter/material.dart';
// import 'package:alpha_learning_app/app/app.dart';
// import 'package:alpha_learning_app/shared/shared.dart';
//
// class NotFoundErrorPage extends StatelessWidget {
//   const NotFoundErrorPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final currentBrightness = context.theme.brightness;
//     final asset = currentBrightness == Brightness.light
//         ? ImageAssets.light404Error
//         : ImageAssets.dark404Error;
//
//     return Scaffold(
//       // TODO(Joshua): Add to localized strings and uncomment
//       appBar: AppBar(
//         title: const Text('Error'),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 256,
//                 width: 384,
//                 child: Image.asset(
//                   asset,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
