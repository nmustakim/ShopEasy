import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopBanner extends StatelessWidget {
  const TopBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Stack(children: [
        Container(
          height: 120,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0XFFE2E9FF), Color(0XFFFFEAEA)]),
              borderRadius: BorderRadius.circular(16)),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Free shipping',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      fontFamily:
                      GoogleFonts.montserrat().fontFamily,
                      color: Colors.red)),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text('When ordering',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily:
                          GoogleFonts.montserrat().fontFamily,
                          color: const Color(0XFF000000))),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0XFFFFBB56)),
                    child: Padding(
                      padding:
                      const EdgeInsets.fromLTRB(8, 3, 8, 3),
                      child: Text('From 50\$',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: GoogleFonts.montserrat()
                                  .fontFamily,
                              color: const Color(0XFF000000))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
