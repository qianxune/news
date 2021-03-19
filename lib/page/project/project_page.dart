import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/provider/project_page_model.dart';
import 'package:flutter_eyepetizer/widget/loading_container.dart';
import 'package:flutter_eyepetizer/widget/provider_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../video_search_page.dart';
import 'ArticleItemPage.dart';

class ProjectPage extends StatefulWidget{
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("项目",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: OpenContainer(
                  closedElevation: 0.0,
                  closedBuilder: (context, action) {
                    return Icon(
                      Icons.search,
                      color: Colors.black87,
                    );
                  },
                  openBuilder: (context, action) {
                    return VideoSearchPage();
                  }),
            )
          ],
        ),
        body: ProviderWidget<ProjectPageModel>(
            model: ProjectPageModel(),
            onModelInit: (model) {
              model.refresh();
            },
            builder: (context, model, child) {
              return LoadingContainer(
                loading: model.loading,
                error: model.error,
                retry: model.retry,
                child: SmartRefresher(
                    controller: model.refreshController,
                    onRefresh: model.refresh,//下拉刷新时调用
                    onLoading: model.loadMore,//上拉加载时调用
                    enablePullUp: true, //是否可以下拉刷新
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          print("zjm banner index");
                          return ArticleItemPage(model.itemList[index]);
                        },
                        separatorBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Divider(
                                  height: 0.5,
                                  color: Color(0xffe6e6e6)));
                        },
                        itemCount: model.itemList.length)),
              );
            }));
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}


