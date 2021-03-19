import 'package:flutter_eyepetizer/api/api_service.dart';
import 'package:flutter_eyepetizer/model/article_list/ArticleItemModel.dart';
import 'package:flutter_eyepetizer/model/article_list/ArticleListDataModel.dart';
import 'package:flutter_eyepetizer/model/article_list/ArticleListModel.dart';
import 'package:flutter_eyepetizer/provider/base_change_notifier_model.dart';
import 'package:flutter_eyepetizer/util/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProjectPageModel extends BaseChangeNotifierModel{

  List<ArticleItemModel> itemList = [];

  String nextPageUrl;
  bool loading = true;
  bool error = false;

  RefreshController refreshController =
  RefreshController(initialRefresh: false);
  var url = '0/json';
  refresh({bool retry = false}) async {
    ApiService.getData(ApiService.PROJECT_LIST+url,//采用回调函数处理请求结果，类似Android开发
        success: (result) async {
          print('taoyijing');
          print(result);
          ArticleListModel issueEntity = ArticleListModel.fromJson(result);
          print(issueEntity.data.curpage);
          print('zhujinming');
          List<ArticleItemModel> _listData = issueEntity.data.datas;
          loading = false;
          print('hahaha');
          itemList.clear();
          itemList.addAll(_listData);
          refreshController.refreshCompleted();
          //await loadMore();
        },
        fail: (e) {
          ToastUtil.showError(e.toString());
        },
        complete: () => notifyListeners());
  }

  Future loadMore() async {
    if (nextPageUrl == null) {
      refreshController.loadNoData();
      return;
    }

    ApiService.getData(nextPageUrl, success: (result) {
      ArticleListDataModel issueEntity = ArticleListDataModel.fromJson(result);
      List<ArticleItemModel> _listData = issueEntity.datas;
      itemList.addAll(_listData);
      refreshController.loadComplete();
      notifyListeners();
    }, fail: (e) {
      ToastUtil.showError(e.toString());
      refreshController.loadFailed();
    });
  }


  retry(){
    loading = true;
    notifyListeners();
    refresh();
  }
}


/*
Widget _buildSinglePage(ProjectClassifyItemModel bean) {
  return ArticleListPage(
    keepAlive: _keepAlive(),
    request: (page) {
      return CommonService().getProjectListData((bean.url == null)
          ? ("${Api.PROJECT_LIST}$page/json?cid=${bean.id}")
          : ("${bean.url}$page/json"));
    },
  );
}*/
