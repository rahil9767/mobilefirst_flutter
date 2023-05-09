import 'package:flutter/material.dart';
import 'package:mobilefirst_flutter/models/response/users_response.dart';
import 'package:mobilefirst_flutter/modules/home/home.dart';
import 'package:mobilefirst_flutter/shared/constants/colors.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../models/news_api_model.dart';

class MainTab extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading : false,
        title: Text("NEWS APP"),
      ),
      body: Obx(
        () => RefreshIndicator(
          child: _buildGridView(),
          onRefresh: () => controller.loadUsers(),
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return MasonryGridView.count(
      crossAxisCount: 1,
      itemCount: data!.length,
      itemBuilder: (BuildContext context, int index) => new Container(
        color: ColorConstants.lightGray,
        child: Padding(
          padding:  EdgeInsets.all(18.0),
          child: Material(
            elevation: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${data![index].title} '),
                CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: data![index].urlToImage ??
                      'https://reqres.in/img/faces/1-image.jpg',
                  placeholder: (context, url) => Image(
                    image: AssetImage('assets/images/icon_success.png'),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Text('${data![index].content}'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Articles>? get data {

    return controller.newsList.value == null ? [] : controller.newsList.value!.articles;
  }
}
