import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myalice/controllers/apiControllers/customerProfileController.dart';
import 'package:myalice/models/responseModels/productInteraction/product_interaction.dart';
import 'package:myalice/utils/colors.dart';
import 'package:myalice/utils/readTimeStamp.dart';

class ProductInteractionScreen extends StatefulWidget {
  ProductInteractionScreen({Key? key}) : super(key: key);

  @override
  _ProductInteractionScreenState createState() =>
      _ProductInteractionScreenState();
}

class _ProductInteractionScreenState extends State<ProductInteractionScreen> {
  CustomerProfileController _controller = Get.find<CustomerProfileController>();
  late ProductInteraction _productInteraction;
  late var _id;
  var _dataAvailable = false.obs;
  
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    var _args = Get.arguments;
    _id = _args[0];
    _productInteraction = await _controller
        .getInteraction(customerID: _id.toString())
        .then((value) {
      if (value!.success!) {
        setState(() {
          _dataAvailable.value = true;
        });
      }
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
     Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text('Product Interaction',
              style: TextStyle(fontSize: 16, color: Colors.black)),
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          bottom: new PreferredSize(
            preferredSize: new Size(50.0, 50.0),
            child: new Container(
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.grey[350]!)),
              child: new TabBar(
                labelColor: Colors.black,
                indicatorPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(color: Colors.grey[350]),
                tabs: [
                  Container(
                    height: 50.0,
                    child: new Tab(
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.dollarSign,
                            size: 15,
                          ),
                          Text("  Bought")
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    child: new Tab(
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.shoppingCart,
                            size: 15,
                          ),
                          Text("  In Cart")
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    child: new Tab(
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.eye,
                            size: 15,
                          ),
                          Text("  Viewed")
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Obx(() {
              if (_dataAvailable.value) {
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount:
                      _productInteraction.dataSource!.boughtProducts!.length,
                  padding: EdgeInsets.all(8.0),
                  itemBuilder: (context, index) {
                    return Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: CachedNetworkImageProvider(
                                                _productInteraction
                                                    .dataSource!.boughtProducts!
                                                    .elementAt(index)
                                                    .productImages!
                                                    .elementAt(0))),
                                        borderRadius: BorderRadius.circular(10)),
                                    height: 150,
                                  ),
                                  Positioned(
                                      top: 125,
                                      left: 115,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AliceColors
                                                .ALICE_SELECTED_CHANNEL),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text("${format.currencySymbol}"+_productInteraction
                                                    .dataSource!.boughtProducts!
                                                    .elementAt(index)
                                                    .unitPrice.toString()),
                                        ),
                                      ))
                                ],
                              ),
                              Expanded(child: Padding(
                                padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                                child: Text( _productInteraction
                                                    .dataSource!.boughtProducts!
                                                    .elementAt(index)
                                                    .productName!),
                              )),

                              Expanded(child: Padding(
                                padding: const EdgeInsets.only(top:8.0,bottom:8.0),
                                child: Text( getDateWithTime(_productInteraction
                                                    .dataSource!.boughtProducts!
                                                    .elementAt(index)
                                                    .timestamp!),style: TextStyle(color: Colors.grey[700]),),
                              )),

                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisExtent: 250.0,
                      mainAxisSpacing: 8.0),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
            Center(
              child: Text("Trains"),
            ),
            Center(
              child: Text("Hotels"),
            ),
          ],
        ),
      ),
    );
  }
}
