import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import '../../contants/appcolors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ThemeMode _themeMode = ThemeMode.system;
  Color clr1 = AppColors.primary_color;
  late DialogFlowtter instance;
  final messageController = new TextEditingController();
  Future<void> getInstance() async {
    instance = await DialogFlowtter.fromFile(
        path: "assets/dialog_flow.json",
        sessionId: "any_random_string_will_do");
  }

  @override
  void initState() {
    getInstance();
    super.initState();
  }

  @override
  void dispose() {
    instance.dispose();
    super.dispose();
  }

  List<Map> messsages = [];

  Future<void> getResponse() async {
    DetectIntentResponse response = await instance.detectIntent(
      queryInput: QueryInput(text: TextInput(text: messageController.text)),
    );
    String? textResponse = response.text;
    print(textResponse);
    setState(() {
      messsages.insert(0, {"data": 0, "message": textResponse});
    });
  }


  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.primary_color,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(top: 28.0, left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Chat",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      maxRadius: 15,
                      backgroundColor: AppColors.primary_color,
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messsages.length,
                    itemBuilder: (context, index) => chat(
                        messsages[index]["message"].toString(),
                        messsages[index]["data"]))),
            Container(
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: Color(0xffF2F4F6),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextFormField(
                    style: TextStyle(
                      color: AppColors.text_black
                    ),
                    controller: messageController,
                    decoration: InputDecoration(
                        hintText: "Send Message",
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none),
                    cursorColor: isDarkMode ? AppColors.primary_color : clr1,
                  ),
                ),
                trailing: GestureDetector(
                  child: Icon(Icons.send_outlined, color: clr1),
                  onTap: () {
                    getResponse();
                    setState(() {
                      messsages.insert(
                          0, {"data": 1, "message": messageController.text});
                    });
                    messageController.clear();
                  },
                ),
              ),
            ),
            SizedBox(height: 10),


          ],
        ),
      ),
    );
  }


  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
        data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundColor: clr1,
              child: Text("Bot", style: TextStyle(color: Colors.white)),
            ),
          )
              : Container(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Bubble(
                borderWidth: data == 0 ? 1 : 0,
                borderColor: clr1,
                radius: Radius.circular(15.0),
                color: data == 0 ? Colors.white : clr1,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 200),
                            child: Text(
                              message,
                              style: data == 0
                                  ? TextStyle(
                                  color: clr1, fontWeight: FontWeight.bold)
                                  : TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ),
                )),
          ),
          data == 1
              ? Container(
            child: CircleAvatar(
              minRadius: 30,
              child: CircleAvatar(
                minRadius: 29,
                backgroundColor: Colors.white,
                child: Text("You", style: TextStyle(color: clr1)),
              ),
              backgroundColor: clr1,
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}
