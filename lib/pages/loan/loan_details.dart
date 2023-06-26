import 'package:flutter/material.dart';
import 'package:flutter_workshop/providers/loandetails_provider.dart';
import 'package:provider/provider.dart';

class LoanDetailsPage extends StatefulWidget {
  const LoanDetailsPage({super.key});

  @override
  State<LoanDetailsPage> createState() => _LoanDetailsPageState();
}

class _LoanDetailsPageState extends State<LoanDetailsPage> {
  @override
  Widget build(BuildContext context) {

    Widget titleSection(String title) {
      return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
        ],
      ),
    );
    }
    // Widget titleSection = Container(
    //   padding: const EdgeInsets.all(32),
    //   child: Row(
    //     children: [
    //       Expanded(
    //         /*1*/
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             /*2*/
    //             Container(
    //               padding: const EdgeInsets.only(bottom: 8),
    //               child: const Text(
    //                 'Oeschinen Lake Campground',
    //                 style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ),
    //             Text(
    //               'Kandersteg, Switzerland',
    //               style: TextStyle(
    //                 color: Colors.grey[500],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       /*3*/
    //       Icon(
    //         Icons.star,
    //         color: Colors.red[500],
    //       ),
    //       const Text('41'),
    //     ],
    //   ),
    // );

    Color color = Theme.of(context).primaryColor;
    Color primaryColor = const Color(0xFF1e8bfa);

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );

    Widget textSection(String details) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(details),
            const Text(
              'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
              'Alps. Situated 1,578 meters above sea level, it is one of the '
              'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
              'half-hour walk through pastures and pine forest, leads you to the '
              'lake, which warms to 20 degrees Celsius in the summer. Activities '
              'enjoyed here include rowing, and riding the summer toboggan run.',
              softWrap: true,
            ),
          ],
        ),
      );
    }

    // Widget textSection = const Padding(
    //   padding: EdgeInsets.all(32),
    //   child: Text(
    //     'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
    //     'Alps. Situated 1,578 meters above sea level, it is one of the '
    //     'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
    //     'half-hour walk through pastures and pine forest, leads you to the '
    //     'lake, which warms to 20 degrees Celsius in the summer. Activities '
    //     'enjoyed here include rowing, and riding the summer toboggan run.',
    //     softWrap: true,
    //   ),
    // );

    return Consumer<LoanDetailsProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          title: Text(value.loandetails['title'] ?? ''),
        ),
        body: ListView(
          children: [
            Image.network(
              value.loandetails['img'] ?? '',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            // titleSection,
            const SizedBox(height: 30,),
            buttonSection,
            textSection(value.loandetails['details'] ?? ''),
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
