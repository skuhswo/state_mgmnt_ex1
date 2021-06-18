import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:state_mgmnt_ex1/model/topic.dart';
import 'package:state_mgmnt_ex1/demo_constants.dart';

class TopicCardWidget extends StatelessWidget {
  final bool fractionOfWidth;

  final Topic topic;

  final Color overlayColor;

  final Function(int id, {String title}) cardTapped;

  const TopicCardWidget(
      {Key key,
      @required this.fractionOfWidth,
      @required this.topic,
      @required this.overlayColor,
      @required this.cardTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var cardWidth = fractionOfWidth ? width * 0.65 : width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          splashColor: Colors.grey,
          onTap: () {
            cardTapped(topic.id, title: topic.title);
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ShaderMask(
                child: Container(
                  width: cardWidth,
                  height: 145,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                       image: NetworkImage(kReleaseMode
                           ? (topic.imageUrl != null)
                               ? topic.imageUrl
                               : DemoConstants.fallbackImage
                           : (topic.imageUrl != null)
                               ? topic.imageUrl
                               : DemoConstants.fallbackImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: Alignment(-0.5, 1.0),
                    end: Alignment.topRight,
                    colors: [overlayColor, Colors.transparent],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcATop,
              ),
              Container(
                width: cardWidth,
                padding: const EdgeInsets.all(12.0),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Spacer(),
                      Text(
                        topic.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      // SingleLineMarkdownBody(
                      //   data: topic.description,
                      //   maxLines: 3,
                      //   overflow: TextOverflow.ellipsis,
                      //   //maxLines: 3,
                      //   styleSheet: MarkdownStyleSheet(
                      //     p: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.w300),
                      //   ),
                      //   //overflow: TextOverflow.ellipsis,
                      // ),
                      SizedBox(
                        height: 6,
                      ),
                      Text.rich(
                        TextSpan(text: "", children: [
                          TextSpan(
                              text: '8 ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: 'Kurse  |  ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                          TextSpan(
                              text: '7 ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: 'Lektionen ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ]),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
