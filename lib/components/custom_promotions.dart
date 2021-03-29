import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:medapp/bloc/promotions/promotions_bloc.dart';
import 'package:medapp/routes/routes.dart';

class Promotions extends StatefulWidget {
  const Promotions({
    Key key,
  }) : super(key: key);

  @override
  _PromotionsState createState() => _PromotionsState();
}

class _PromotionsState extends State<Promotions> {
  final PromotionsBloc promotionsBloc = PromotionsBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    promotionsBloc.add(GetListPromotions());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => promotionsBloc,
      child: BlocBuilder<PromotionsBloc, PromotionsState>(
        builder: (context, state) {
          if (state is PromotionsLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: ScreenUtil().setHeight(200),
                width: double.infinity,
                // decoration: BoxDecoration(
                //   color: Colors.amberAccent,
                //   borderRadius: BorderRadius.circular(20),
                // ),
                child: Swiper(
                  autoplay: true,
                  layout: SwiperLayout.DEFAULT,
                  itemCount: state.listPromotions.data.length,
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.promotionDetail, arguments: state.listPromotions.data[index]);
                      },
                      child: CachedNetworkImage(
                        imageUrl: state.listPromotions.data[index].hinhAnh,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
