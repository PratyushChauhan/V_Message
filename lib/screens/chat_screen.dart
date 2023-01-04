import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String messageText;
  TextEditingController messageController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  //init state
  @override
  void initState() {
    super.initState();
    getLoggedinUser();
  }

  void getLoggedinUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        popupSuccess(context, "Logged in as ${loggedInUser.email}");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        popupLogout(context, _auth);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Image.asset('images/logo.png'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  popupLogout(context, _auth);
                }),
          ],
          //title with an asset image

          title: Text('Chat'),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              FirebaseChatList(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //handle exception
                        try {
                          messageController.clear();
                          _firestore.collection("messages").add({
                            "text": messageText,
                            "sender": loggedInUser.email,
                            "timestamp": DateTime.now(),
                          });
                        } catch (e) {
                          popupError(context, e.toString());
                        }
                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirebaseChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          _firestore.collection("messages").orderBy("timestamp").snapshots(),
      builder: (context, snapshot) {
        //build a list of messages
        List<MessageBubble> messageBubbles = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        //loop through the messages
        for (var message in messages) {
          String messageText = message.data()['text'];
          String sender = message.data()['sender'];
          final messageBubble = MessageBubble(
            sender: sender,
            text: messageText,
            isMe: loggedInUser.email == sender,
          );
          messageBubbles.add(messageBubble);
        }
        print('User: ' + loggedInUser.email);
        return Expanded(
          child: ListView(
            //make it scroll to the latest message
            reverse: true,
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});

  String sender;
  String text;
  bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                '$sender',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black38,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: getBorderRadius(isMe),
                  color: isMe ? Colors.lightBlueAccent : Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          '$text',
                          style: TextStyle(
                              fontSize: 15,
                              color: isMe ? Colors.white : Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

BorderRadius getBorderRadius(bool isMe) {
  if (isMe) {
    return BorderRadius.only(
      topLeft: Radius.circular(30.0),
      bottomLeft: Radius.circular(30.0),
      bottomRight: Radius.circular(30.0),
    );
  } else {
    return BorderRadius.only(
      topRight: Radius.circular(30.0),
      bottomLeft: Radius.circular(30.0),
      bottomRight: Radius.circular(30.0),
    );
  }
}
