import 'package:flutter_eyepetizer/model/article_list/ArticleListDataModel.dart';
import 'package:json_annotation/json_annotation.dart';

import '../RootModel.dart';


part 'ArticleListModel.g.dart';

@JsonSerializable()
class ArticleListModel extends RootModel<ArticleListDataModel> {
  ArticleListModel(ArticleListDataModel data, int errorCode, String errorMsg)
      : super(data, errorCode, errorMsg);

  factory ArticleListModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleListModelFromJson(json);
}
