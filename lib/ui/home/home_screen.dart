import 'package:chat_app/base/base.dart';
import 'package:chat_app/shared_data.dart';
import 'package:chat_app/ui/addRoom/add_room_screen.dart';
import 'package:chat_app/ui/home/home_viewmodel.dart';
import 'package:chat_app/ui/home/room_widget.dart';
import 'package:chat_app/ui/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }

  @override
  void initState() {
    super.initState();
    viewModel.loadRooms();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/images/signin.png"),
                fit: BoxFit.fill)),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Chat App"),
            actions: [
              InkWell(
                child: Icon(Icons.logout_outlined),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  SharedData.user = null;
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(child: Consumer<HomeViewModel>(
                builder: (context, HomeViewModel, child) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return RoomWidget(HomeViewModel.rooms[index]);
                    },
                    itemCount: HomeViewModel.rooms.length,
                  );
                },
              )),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddRoomScreen.routeName);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
