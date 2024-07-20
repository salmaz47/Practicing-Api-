import 'package:flutter/material.dart';

import 'package:practice_api/user_services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final items = List.generate(50, (i) => i);
  late Future<List<User>> futureUsers;
  @override
void initState() 
{
  super.initState();
  futureUsers = UserService().getUser();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
      ),
      body: Center(
        child: FutureBuilder(
          future: futureUsers, 
          builder: ((context,AsyncSnapshot snapshot){
            if (snapshot.hasData){
              return ListView.separated(
                itemBuilder:(context, index){
                       User user =snapshot.data?[index];
                       return ListTile(
                        title: Text(user.email),
                        subtitle: Text(user.name.first),
                        trailing: Icon(Icons.chevron_right_outlined),
                        onTap: (()=> {openPage(context,user)}),
                       );
                } ,
                 separatorBuilder: ((context,index){
                  return const Divider(color: Colors.black26,);
                 })
                 ,
                  itemCount: snapshot.data!.length
                  );
            }else if(snapshot.hasError)
            {
                return Text('ERROR: ${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }) 
          ),
      )
    );
  }

  void openPage(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage()),
    );
  }
}

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Page'),
      ),
      body: Center(
        child: Text('Details Page Content'),
      ),
    );
  }
}
