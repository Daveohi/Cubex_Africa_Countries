// import 'package:flutter/material.dart';

// class ErrorMessageWidget extends StatelessWidget {
//   final String message;
//   final VoidCallback? onRetry;

//   const ErrorMessageWidget({
//     super.key,
//     required this.message,
//     this.onRetry,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(message, style: const TextStyle(color: Colors.red)),
//           if (onRetry != null) ...[
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: onRetry,
//               child: const Text('Retry'),
//             )
//           ]
//         ],
//       ),
//     );
//   }
// }
