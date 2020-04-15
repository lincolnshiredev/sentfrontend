//Package Imports
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//In File Imports
import '../../components/loading.dart';
import '../../models/post_model.dart';
import '../../models/stock_info_model.dart';
import '../../repository.dart';
import '../../screens/post_screen.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  //Same as the Root Bloc but for news or post detail this time. :)

  Repository repository = Repository();
  final Post post;
  PostBloc({@required this.post});
  @override
  PostState get initialState => PostInitial();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is InitializePost) {
      var prices = await repository.loadPrices(event.ticker);
      var stock = await repository.loadStock(event.ticker);

      var stockInfoModel = StockInfoModel(
        numberOfArticles: stock.additionalData.numberOfArticles,
        sentiment: stock.additionalData.avgSentiment,
        image: prices.profile.image,
        price: prices.profile.price,
      );

      yield PostScreenInFront(
        PostDetail(
          post: post,
          prices: prices,
          stock: stock,
          stockInfoModel: stockInfoModel,
        ),
      );
    }
  }
}
