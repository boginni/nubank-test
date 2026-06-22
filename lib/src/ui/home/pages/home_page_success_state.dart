// import 'package:flutter/material.dart';
//
// class HomePageSuccessState extends StatelessWidget {
//   const HomePageSuccessState({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           const SliverAppBar(
//             title: Text(
//               'Nu test',
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const .all(16),
//               child: Form(
//                 key: store.formKey,
//                 child: Row(
//                   spacing: 8,
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         controller: store.urlController,
//                         validator: (value) {},
//                         autovalidateMode: .onUserInteraction,
//                         decoration: const InputDecoration(
//                           contentPadding: .symmetric(
//                             vertical: 0,
//                             horizontal: 16,
//                           ),
//                           hint: Text('https://'),
//                           label: Text('Url'),
//                         ),
//                       ),
//                     ),
//                     IconButton.filled(
//                       onPressed: () {},
//                       icon: const Icon(Icons.send),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: const .symmetric(horizontal: 16),
//             sliver: SliverList.builder(
//               itemBuilder: (context, int index) {
//                 return const ListTile(
//                   title: Text('title'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
