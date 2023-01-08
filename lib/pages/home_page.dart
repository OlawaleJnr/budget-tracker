import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView( // Allows the column to be scrollable
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          width: screenSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: CircularPercentIndicator(
                  radius: screenSize.width / 2,
                  lineWidth: 10.0, // how thick the line is
                  percent: .5, // percent goes from 0 -> 1
                  backgroundColor: Colors.white,
                  center: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "\$0",
                        style: GoogleFonts.urbanist(
                          fontSize: 48, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Balance",
                        style: GoogleFonts.urbanist(
                          fontSize: 18, 
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  progressColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                "Items",
                style: GoogleFonts.urbanist(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
            ],
          )
        ),
      ),
    );
  }
}