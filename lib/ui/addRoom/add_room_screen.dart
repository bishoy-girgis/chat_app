import 'package:chat_app/base/base.dart';
import 'package:chat_app/model/room_cat.dart';
import 'package:chat_app/ui/addRoom/add_room_viewmodel.dart';
import 'package:chat_app/ui/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = "Add room";

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseState<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  List<RoomCategory> allCatgs = RoomCategory.getRoomCategory();
  late RoomCategory selectedRoomCategory;
  var formKey = GlobalKey<FormState>();
  TextEditingController name= TextEditingController();
  TextEditingController desc = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedRoomCategory = allCatgs[0];
  }

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
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
            title: const Text("Add Room"),
          ),
          body: Card(
            margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 26),
            elevation: 12,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Creat New Room",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Image.asset("assets/images/addroom.png"),
                      TextFormField(
                        controller: name,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "please enter room title";
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(labelText: "Room Name"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Room Category : ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          DropdownButton(
                            value: selectedRoomCategory,
                            items: allCatgs.map((catgs) {
                              return DropdownMenuItem<RoomCategory>(
                                value: catgs,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Image.asset(
                                          "assets/images/${catgs.imageName}",
                                          width: 48,
                                          height: 48),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(catgs.name),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                selectedRoomCategory = value;
                              });
                            },
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: desc,
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "please enter room description";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: "Room Description"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 25),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))),
                            onPressed: () {submit();},
                            child: const Text("Create")),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void submit(){
    if(formKey.currentState?.validate()==false) return ;
      viewModel.addRoom(name.text, desc.text, selectedRoomCategory.id);
  }

  @override
  void goBack() {
    Navigator.pushNamed(context, HomeScreen.routeName);
  }
}
