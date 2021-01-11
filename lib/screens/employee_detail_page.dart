import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/custom_libraries/custom_loader/RoundedLoader.dart';
import 'package:machine_test/custom_libraries/text_drawable/TextDrawableWidget.dart';
import 'package:machine_test/custom_libraries/text_drawable/color_generator.dart';
import 'package:machine_test/models/employee_list_model.dart';
import 'package:machine_test/utilities/login_model.dart';
import 'package:shimmer/shimmer.dart';

class EmployeeDetailScreen extends StatefulWidget {
  EmployeeListModel itemDetail;

  EmployeeDetailScreen({@required this.itemDetail});

  @override
  _EmployeeDetailScreenState createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  @override
  void initState() {
    super.initState();
    LoginModel().currentContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
          color: widget.itemDetail != null ? Colors.white : Colors.transparent,
          child: widget.itemDetail != null
              ? SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 15, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildImageWidget(),
                _buildName(),
                _buildPhone(),
                _buildEmail(),
                _buildAddress(),
                _buildCompany()
              ],
            ),
          )
              : Container()),),
    );
  }

  Widget _buildName() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Text(
        widget.itemDetail != null
            ? widget.itemDetail.name != null
                ? widget.itemDetail.name
                : ""
            : "",
        textAlign: TextAlign.left,
        style: TextStyle(
            fontFamily: 'roboto',
            color: Colors.black,
            fontSize: 18.0,
            height: 1.5,
            wordSpacing: 1.5),
      ),
      color: widget.itemDetail != null ? Colors.white : Colors.transparent,
    );
  }

  Widget _buildPhone() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.phone,
              size: 15,
            ),
          ),
          Text(
            widget.itemDetail != null
                ? widget.itemDetail.phone != null
                    ? widget.itemDetail.phone
                    : ""
                : "",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'roboto',
              color: Colors.grey[700],
              fontSize: 14.0,
            ),
          ),
        ],
      ),
      color: widget.itemDetail != null ? Colors.white : Colors.transparent,
    );
  }

  Widget _buildAddress() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.location_on,
                  size: 15,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemDetail != null
                        ? widget.itemDetail.address != null
                            ? widget.itemDetail.address.street != null
                                ? widget.itemDetail.address.street
                                : ""
                            : ""
                        : "",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'roboto',
                      color: Colors.grey[700],
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    widget.itemDetail != null
                        ? widget.itemDetail.address != null
                            ? widget.itemDetail.address.city != null
                                ? widget.itemDetail.address.city
                                : ""
                            : ""
                        : "",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'roboto',
                      color: Colors.grey[700],
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    widget.itemDetail != null
                        ? widget.itemDetail.address != null
                            ? widget.itemDetail.address.zipcode != null
                                ? widget.itemDetail.address.zipcode
                                : ""
                            : ""
                        : "",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'roboto',
                      color: Colors.grey[700],
                      fontSize: 14.0,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
      color: widget.itemDetail != null ? Colors.white : Colors.transparent,
    );
  }

  Widget _buildCompany() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.work,
                  size: 15,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemDetail != null
                        ? widget.itemDetail.company != null
                            ? widget.itemDetail.company.name != null
                                ? widget.itemDetail.company.name
                                : ""
                            : ""
                        : "",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'roboto',
                      color: Colors.grey[700],
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    widget.itemDetail != null
                        ? widget.itemDetail.company != null
                            ? widget.itemDetail.company.catchPhrase != null
                                ? widget.itemDetail.company.catchPhrase
                                : ""
                            : ""
                        : "",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'roboto',
                      color: Colors.grey[700],
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    widget.itemDetail != null
                        ? widget.itemDetail.company != null
                            ? widget.itemDetail.company.bs != null
                                ? widget.itemDetail.company.bs
                                : ""
                            : ""
                        : "",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'roboto',
                      color: Colors.grey[700],
                      fontSize: 14.0,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
      color: widget.itemDetail != null ? Colors.white : Colors.transparent,
    );
  }

  Widget _buildEmail() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.email,
              size: 15,
            ),
          ),
          Text(
            widget.itemDetail != null
                ? widget.itemDetail.email != null
                    ? widget.itemDetail.email
                    : ""
                : "",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'roboto',
              color: Colors.grey[700],
              fontSize: 14.0,
            ),
          )
        ],
      ),
      color: widget.itemDetail != null ? Colors.white : Colors.transparent,
    );
  }

  Widget _buildImageWidget() {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      width: double.infinity,
      child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: widget.itemDetail != null
              ? widget.itemDetail.profileImage != null
                  ? widget.itemDetail.profileImage
                  : ""
              : "",
          placeholder: (context, url) => Padding(
                child: RoundedLoader(),
              ),
          errorWidget: (context, url, error) => TextDrawableWidget(
                  widget.itemDetail.name, ColorGenerator.materialColors,
                  (bool selected) {
                // on tap callback
                print("on tap callback");
              }, false, 110.0, 110.0, BoxShape.circle,
                  TextStyle(color: Colors.white, fontSize: 30.0))),
    );
  }
}
