import 'dart:io';

import 'model/topic.dart';
import 'model/topic_details.dart';
import 'model/topics.dart';

class Client {

  Topics getTopics() {
    var myTopics = Topics();
    var topic1 = Topic("Android", "Thema 1 Beschreibung", "https://miro.medium.com/max/4096/1*FhefRHwEXt63Uo9RLTQf3w.jpeg", 1);
    var topic2 = Topic("Flutter", "Thema 2 Beschreibung", "https://miro.medium.com/max/4096/1*FhefRHwEXt63Uo9RLTQf3w.jpeg", 2);
    myTopics.topics.add(topic1);
    myTopics.topics.add(topic2);
    return myTopics;
  }

  Topic getTopic(int id) {
    if (id == 1) {
      var topic1 = Topic("Android 1", "Thema 1 Beschreibung",
          "https://miro.medium.com/max/4096/1*FhefRHwEXt63Uo9RLTQf3w.jpeg", 1);
      return topic1;
    } else {
      var topic2 = Topic("Flutter", "Thema 1 Beschreibung",
          "https://miro.medium.com/max/4096/1*FhefRHwEXt63Uo9RLTQf3w.jpeg", 1);
      return topic2;
    }
  }

}