import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tif_assg/main.dart';
import 'package:tif_assg/modles/user_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.e}) : super(key: key);
  final UserModel e;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(e.dateTime);
    String formattedDateTime1 = DateFormat('d MMMM, y').format(dateTime);
    String formattedDateTime2 =
        DateFormat('EEEE, h:mm a').format(dateTime) +
            ' - ' +
            DateFormat('h:mm a').format(dateTime.add(const Duration(hours: 5)));

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Back Container with Image
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(e.bannerImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 500,
                ),
                // Front Container with Text
                Transform.translate(
                  offset: const Offset(0, -35),
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, top: 2, right: 0, bottom: 0),
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyApp(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Event Details',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 80),
                        Card(
                          color: Colors.white.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const SizedBox(
                            width: 40,
                            height: 40,
                            child: const Center(
                              child: Icon(
                                Icons.bookmark_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const SizedBox(height: 20),
                Text(
                  e.organiserName,
                  style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
                Card(
                  child: ListTile(
                    leading: Container(
                      width: 54, // Adjust the width as needed
                      height: 51.68, // Adjust the height as needed
                      child: Image.network(
                        e.organiserIcon,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      e.organiserName,
                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                    subtitle: const Text(
                      'Organizer',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Card(
                      color: Colors.white.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: Center(
                          child: Image.asset(
                            'images/Calendar.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      formattedDateTime1,
                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                    subtitle: Text(
                      formattedDateTime2,
                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Card(
                      color: Colors.white.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                        child: Center(
                          child: Image.asset(
                            'images/location.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      e.venueName,
                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                    subtitle: Text(
                      '${e.venueCity}, ${e.venueCountry}',
                      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'About Event',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  e.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            // padding: const EdgeInsets.all(10),
            child: Container(
              height: 85, // Adjust the height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/button.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
