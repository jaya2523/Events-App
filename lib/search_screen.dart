import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tif_assg/detail_screen.dart';
import 'package:tif_assg/main.dart';
import 'package:tif_assg/modles/user_model.dart';
import 'package:tif_assg/repos/repositories.dart';

void main() {
  runApp(const SearchPage());
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => UserRepository(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController searchController = TextEditingController();
  List<UserModel> filteredList = []; // Filtered list to be displayed

  @override
  void initState() {
    super.initState();
    // Load the initial full list of users
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    // Fetch the full list of users from the API
    // Populate the filteredList with the fetched data
    // For example:
    List<UserModel> userList = await UserRepository().getUsers();
    setState(() {
      filteredList = userList;
    });
  }

  void filterUsers(String query) {
    query = query.toLowerCase().trim(); // Convert to lowercase and remove leading/trailing whitespaces
    List<UserModel> filteredUsers = []; // Temporary list to store filtered users

    // Filter the users based on the search query
    if (query.isNotEmpty) {
      filteredUsers = filteredList.where((user) {
        return user.organiserName.toLowerCase().contains(query) ||
            user.venueName.toLowerCase().contains(query) ||
            user.venueCity.toLowerCase().contains(query) ||
            user.venueCountry.toLowerCase().contains(query);
      }).toList();
    } else {
      filteredUsers = List.from(filteredList);
    }

    setState(() {
      filteredList = filteredUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                icon: const Icon(Icons.arrow_back),
                color: const Color(0xFF120D26),
                iconSize: 28,
              ),
              const SizedBox(width: 8),
              const Text(
                'Events',
                style: TextStyle(
                  color: Color(0xFF120D26),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.search),
                  title: TextField(
                    controller: searchController,
                    onChanged: filterUsers,
                    decoration: const InputDecoration(
                      hintText: 'Type Event Name',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (_, index) {
                  UserModel user = filteredList[index];
    
                  // Format the date and time
                  DateTime dateTime = DateTime.parse(user.dateTime);
                  String formattedDateTime = DateFormat('E, MMM y • h:mm a').format(dateTime);
    
                  // Format the venue information
                  String venueInfo = '${user.venueName} • ${user.venueCity}, ${user.venueCountry}';
    
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            e: filteredList[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            user.bannerImage,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Expanded(
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$formattedDateTime',
                                    style: const TextStyle(
                                      color: Color(0xFF5669FF),
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${user.organiserName}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF120D26),
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on, size: 23, color: Colors.grey),
                                      const SizedBox(width: 2),
                                      Flexible(
                                        child: Text(
                                          '$venueInfo',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
