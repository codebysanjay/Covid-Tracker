import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CardDetail(
                "Wear Mask\n when ever\nyou go out",
                "assets/waermask.png",
                Colors.indigo,
              ),
              CardDetail(
                "Keep Social\nDistancing",
                "assets/social.png",
                Colors.teal,
              ),
              CardDetail(
                "use cash\nless payments",
                "assets/cashless.png",
                Colors.cyan,
              ),
              CardDetail(
                "sanitize\nyour hand\nregularly",
                "assets/sanitize.png",
                Colors.deepPurple,
              ),
              CardDetail(
                "cover your\nmouth while\ncoughing",
                "assets/cough.png",
                Colors.indigo,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardDetail extends StatelessWidget {
  final String content;
  final String imageName;
  final Color color;
  const CardDetail(
    this.content,
    this.imageName,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white.withOpacity(0.9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            content.toUpperCase(),
            style: GoogleFonts.ubuntu(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
          Image(
            height: 100,
            image: AssetImage(imageName),
          ),
        ],
      ),
    );
  }
}
