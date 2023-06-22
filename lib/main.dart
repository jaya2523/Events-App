import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assg/detail_screen.dart';
import 'package:tif_assg/modles/user_model.dart';
import 'package:tif_assg/repos/repositories.dart';
import 'package:intl/intl.dart';
import 'package:tif_assg/search_screen.dart';

import 'blocs/app_blocs.dart';
import 'blocs/app_events.dart';
import 'blocs/app_states.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(create: (context) => UserRepository(),
      child: const Home(),
      ),
    );
  }
}
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(RepositoryProvider.of<UserRepository>(context))..add(LoadUserEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Events',style:TextStyle(
            color: Color(0xFF120D26),
          )
          ),
          actions: <Widget>[
            IconButton(onPressed: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => SearchPage(),));
            }, icon: const Icon(Icons.search_outlined),
            color: Color(0xFF120D26),
            iconSize: 28,
            ),
            IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert),
            color: Color(0xFF120D26),
            iconSize: 28,
            ),
          ],
          elevation: 0,
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
if (state is UserLoadedState) {
  List<UserModel> userList = state.users;
  return ListView.builder(
    itemCount: userList.length,
    itemBuilder: (_, index) {
      UserModel user = userList[index];

      // Format the date and time
      DateTime dateTime = DateTime.parse(user.dateTime);
      String formattedDateTime = DateFormat('E, MMM y • h:mm a').format(dateTime);

      // Format the venue information
      String venueInfo = '${user.venueName} • ${user.venueCity}, ${user.venueCountry}';

      return InkWell(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetailScreen(
              e: userList[index],
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
                      Text('$formattedDateTime',
                      style:TextStyle(
                        color: Color(0xFF5669FF),
                        fontSize: 13,
                      )),
                      const SizedBox(height: 8),
                      Text('${user.organiserName}',
                      style:TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF120D26),
                        fontSize: 15,

                      )),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 23, color: Colors.grey),
                          const SizedBox(width: 2),
                          Flexible(
                            child: Text('$venueInfo',
                            style:TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            )
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
  );
}

            if (state is UserErrorState) {
              return Center(child: Text("Error: ${state.error}"));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
