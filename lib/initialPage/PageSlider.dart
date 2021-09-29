import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageSlider {
  String _image;
  String _title;
  String _subtitle;
  int _id;

  PageSlider(this._image, this._title, this._subtitle, this._id);
  widgets(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Positioned(
            top: -60.0,
            left: -40.0,
            child: Container(
              margin: EdgeInsets.only(left: 0.0, top: 0.0),
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  color: Color(0xFFDB5C00).withOpacity(0.03),
                  shape: BoxShape.circle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 12,
                    child: this._id == 1
                        ? Container(
                            height: double.infinity,
                            child: Stack(
                                alignment: AlignmentDirectional.topCenter,
                                children: [
                                  Positioned(
                                    bottom: 0.0,
                                    child: SvgPicture.asset(this._image,
                                        matchTextDirection: true,
                                        placeholderBuilder: (_) =>
                                            CircularProgressIndicator(),
                                        width: media.width * 0.3,
                                        height: media.width * 0.3),
                                  ),
                                  Positioned(
                                    top: 0.0,
                                    right: 0.0,
                                    child: SvgPicture.asset(
                                        "lib/assets/images/delivery_2.svg",
                                        matchTextDirection: true,
                                        placeholderBuilder: (_) =>
                                            CircularProgressIndicator(),
                                        width: media.width * 0.4,
                                        height: media.width * 0.4),
                                  ),
                                ]),
                          )
                        : SvgPicture.asset(this._image,
                            placeholderBuilder: (_) =>
                                CircularProgressIndicator(),
                            width: media.width * 0.1,
                            height: media.width * 0.1),
                  ),
                  SizedBox(
                    height: media.height * 0.05,
                  ),
                  Text(
                    this._title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: media.height * 0.02,
                  ),
                  Text(this._subtitle,
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
                  SizedBox(
                    height: media.height * 0.05,
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
