import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:state_mgmnt_ex1/cubit/error_cubit/error_cubit.dart';
import 'package:state_mgmnt_ex1/cubit/topic_details_cubit/topic_details_cubit.dart';
import 'package:state_mgmnt_ex1/pages/shared_components/topic_card_widget.dart';
import 'package:state_mgmnt_ex1/cubit/topics_cubit/topicspage_cubit.dart';
import 'package:state_mgmnt_ex1/pages/topics_details/topic_details_page.dart';
import 'package:state_mgmnt_ex1/client.dart';

import '../../UIUtils.dart';

class TopicsPage extends StatelessWidget {
  static const routeName = '/topicsPage';

  TopicsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UiUtils.appBarTrianglesFromTop(context),
      body: SafeArea(
        child: BlocBuilder<TopicspageCubit, TopicspageState>(
          builder: (context, state) {
            if (state is TopicspageLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopicspageLoadError) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12),
                    child: Text(
                      "Alle Kurse",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CircularProgressIndicator(),
                ],
              );
            } else if (state is TopicspageLoadSuccess) {
              var list = state.topics;
              return ListView.builder(
                  itemCount: list.length + 1,
                  itemBuilder: (_, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12),
                        child: Text(
                          "Alle Themen",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TopicCardWidget(
                          fractionOfWidth: false,
                          topic: list[index - 1],
                          overlayColor: index % 2 == 0
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).accentColor,
                          cardTapped: (id, {title}) async {
                            await pushNewScreenWithRouteSettings(
                              context,
                              screen: BlocProvider<TopicDetailsCubit>(
                                create: (context) => TopicDetailsCubit(Client(),
                                    BlocProvider.of<ErrorCubit>(context), id),
                                child: TopicDetailsPage(),
                              ),
                              settings: RouteSettings(
                                  name: TopicDetailsPage.routeName),
                            );
                            await FlutterStatusbarcolor
                                .setStatusBarWhiteForeground(true);
                          },
                        ),
                      );
                    }
                  });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
