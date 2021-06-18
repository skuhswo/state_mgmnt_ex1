import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:state_mgmnt_ex1/cubit/topic_details_cubit/topic_details_cubit.dart';
import 'package:state_mgmnt_ex1/model/topic.dart';

import '../../UIUtils.dart';
import '../../demo_constants.dart';

class TopicDetailsPage extends StatelessWidget {
  static const routeName = '/topicDetailsPage';

  bool calledGetData = false;

  @override
  Widget build(BuildContext context) {
    if (!calledGetData) {
      calledGetData = true;
      BlocProvider.of<TopicDetailsCubit>(context).getTopic(context: context);
    }
    UiUtils.setStatusBarColor(Colors.transparent, true);
    return Scaffold(
      body: BlocBuilder<TopicDetailsCubit, TopicDetailsState>(
        builder: (context, state) {
          if (state is TopicDetailsLoading) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    child: BackButton(
                      color: DemoConstants.demoAccentBlue,
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Expanded(
                    child: Align(
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is TopicDetailsLoadSuccess) {
            List<Widget> list = [
              headerElement(context, state.topic),
              SizedBox(
                height: 12,
              )
            ];

            /*
            for (int i = 0; i < state.topic.courses.length; i++) {
              list.add(ActiveCourseCardWidget(
                state.topic.courses[i],
                hideTopic: true,
                onTapCallback: () async {
                  BlocProvider.of<TopicDetailsCubit>(context).getTopic();
                  await FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
                },
              ));
            }
*/

            return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constrains) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constrains.maxHeight,
                      ),
                      child: Column(
                        children: list,
                      )));
            });
          }
          return Center(
            child: Text("Hello"),
          );
        },
      ),
    );
  }

  Widget headerElement(BuildContext context, Topic topic) {
    var headerHeight = 275.0;

    return Container(
      height: headerHeight,
      child: Stack(
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            height: headerHeight,
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
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 6,
            child: BackButton(
              color: DemoConstants.demoAccentBlue,
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                _topicTitle(context, topic.title),
                _topicDetails(context, topic)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _topicTitle(BuildContext context, String title) {
    var fontsize = 22.0;
    var padding = 12.0;
    var height = fontsize + padding * 4;

    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          height: height,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
        ),
        Positioned(
          right: -30,
          bottom: -height * 1.5,
          child: Transform.rotate(
            angle: -5 * pi / 180,
            child: Container(
              height: height * 2,
              width: MediaQuery.of(context).size.width * 1.5,
              color: DemoConstants.demoAccentBlueOpacityReduced,
            ),
          ),
        ),
        Positioned(
          right: -20,
          bottom: -25,
          child: Transform.rotate(
            angle: 8 * pi / 180,
            child: Container(
              height: height,
              width: MediaQuery.of(context).size.width * 1.5,
              color: DemoConstants.demoAccentBlue,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(padding, padding, padding, 2),
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: fontsize,
                color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _topicDetails(BuildContext context, Topic topic) {
    return Container(
      color: DemoConstants.demoAccentBlue,
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          MarkdownBody(
            data: topic.description,
            styleSheet: MarkdownStyleSheet(
              p: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                "5 ",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "Kurse | ",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                "4 ",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                "Lektionen",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
