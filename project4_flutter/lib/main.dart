// import 'package:flutter/material.dart';

// void main() {
//   runApp(DeeApp());
// }

// class DeeApp extends StatelessWidget {
//   const DeeApp({super.key});


//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Dee Flutter App",
//       home : Scaffold(
//         appBar: AppBar(
//           title: Text("Dee App Bar"),
//           backgroundColor: const Color.fromARGB(255, 236, 142, 173),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Center(
//               child: Text(
//                 "hey there, I'm Dee",
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: const Color.fromARGB(255, 160, 25, 110),
//                   fontFamily: 'Arial',
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: Text(
//                 "This is a simple Flutter application.",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.black87,
//                   fontFamily: 'Arial',
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )
//     );
//   }
// }


// import 'package:flutter/material.dart';

// void main() {
//   runApp(DeeApp());
// }

// class DeeApp extends StatelessWidget {
//   const DeeApp({super.key});


//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Dee Flutter App",
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             "Balonku ada 5",
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               fontFamily: 'Arial',
//             ),
//           ),
//           backgroundColor: Colors.blue,
//           centerTitle: false,
//           foregroundColor: Colors.white,
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               "Balonku ada 5\nRupa-rupa warnanya\nHijau, kuning, kelabu\nMerah muda dan biru",
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//                 fontFamily: 'Arial',
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Meletus balon hijau\nHatiku sangat kacau\nBalonku tinggal 4\nKupegang erat-erat",
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.grey[700],
//                 fontFamily: 'Arial',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

void main() {
  runApp(const DeeApp());
}

class DeeApp extends StatelessWidget {
  const DeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lirik Lagu",
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "🎧 Album : Rosie",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Arial',
            ),
          ),
           backgroundColor: Color(0xFFB22222), 
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
          color: Color.fromARGB(255, 241, 177, 185),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // cover album
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/image/rojeh.png", 
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                              const SizedBox(height: 30),
              // judul lagu
              const Text(
                "3AM - Rose",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB22222),
                ),
              ),
               SizedBox(height: 20),

                // lirik
               Text(
                  """

Eh-eh eh-eh eh-eh
I just saw a red flag
Gonna pretend i didn`t see that
Cause is it really, really that bad?
I need you really, really that bad

So can we keep the story rollin'?
Forget that shit my mother always told me
'Cause nothing's really perfect like that
I need you really, really that bad
I need you really, really that bad

The one I run to
Take my makeup off and say good night to
The one I pretty-talk and ugly-cry to
The world can roll their eyes, but there's no use
I just want it to be you
When it's 3 a.m.
And I'm losin' myself and my mind again
The one who gives me love that is bulletproof
The world can roll their eyes, but there's no use                                     
I just want it to be you
Eh-eh, eh-eh, eh-eh
I just want it to be you
Eh-eh, eh-eh, eh-eh
I just want it be you

Hold me, kiss me on my face
Talk shit about the world with me all day
But even when I'm puttin' you through hell
Say I'm not like anyone else
Slowly, words roll off my tongue
You're everything I need, and it's so dumb
And even when you're puttin' me through hell
You're not like anyone else

The one I run to
Take my makeup off and say good night to
The one I pretty-talk and ugly-cry to
The world can roll their eyes, but there's no use
I just want it to be you
When it's 3 a.m.
And I'm losin' myself and my mind again
The one who gives me love that is bulletproof
The world can roll their eyes, but there's no use
I just want it to be you
Eh-eh, eh-eh, eh-eh
I just want it to be you
Eh-eh, eh-eh, eh-eh
I just want it be you
Eh-eh, eh-eh, eh-eh
I just want it to be you
Eh-eh, eh-eh, eh-eh
I just want it to be you

...

                  """,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Color(0xFFB22222),
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

