import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/DBProvider/DBProvider.dart';
import 'package:machine_test/bloc/employee_list_bloc.dart';
import 'package:machine_test/constants/common_methods.dart';
import 'package:machine_test/custom_libraries/custom_loader/RoundedLoader.dart';
import 'package:machine_test/custom_libraries/text_drawable/TextDrawableWidget.dart';
import 'package:machine_test/custom_libraries/text_drawable/color_generator.dart';
import 'package:machine_test/models/employee_list_model.dart';
import 'package:machine_test/screens/employee_detail_page.dart';
import 'package:machine_test/service_manager/ApiResponse.dart';
import 'package:machine_test/utilities/login_model.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EmployeeListBloc employeeListBloc;
  bool hasData = false;
  bool hasFiltered = false;
  var textSearchController = TextEditingController();
  FocusNode searchFocus = FocusNode();

  String searchKey = "";

  @override
  void initState() {
    employeeListBloc = new EmployeeListBloc();

    checkOfflineData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.transparent,
          child: Column(children: <Widget>[
            _buildSearchBox(),
            Expanded(
              child: Scaffold(
                body: hasFiltered
                    ? FutureBuilder(
                        future: DBProvider.db.getAllFilteredList(searchKey),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return _buildLoadingWidget();
                            default:
                              if (snapshot.hasData) {
                                List<EmployeeListModel> employeeList =
                                    snapshot.data;
                                return _buildEmployeeList(employeeList);
                              } else {
                                return _buildErrorWidget('${snapshot.error}');
                              }
                          }
                        })
                    : hasData
                        ? FutureBuilder(
                            future: DBProvider.db.getAllEmployees(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return _buildLoadingWidget();
                                default:
                                  if (snapshot.hasData) {
                                    List<EmployeeListModel> employeeList =
                                        snapshot.data;
                                    return _buildEmployeeList(employeeList);
                                  } else {
                                    return _buildErrorWidget(
                                        '${snapshot.error}');
                                  }
                              }
                            })
                        : FutureBuilder(
                            future: employeeListBloc.getAllEmployees(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return _buildLoadingWidget();
                                default:
                                  if (snapshot.hasData) {
                                    List<EmployeeListModel> employeeList =
                                        snapshot.data;
                                    return _buildEmployeeList(employeeList);
                                  } else {
                                    return _buildErrorWidget(
                                        '${snapshot.error}');
                                  }
                              }
                            }),
              ),
              flex: 1,
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      height: 50.0,
      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ]),
                alignment: FractionalOffset.centerLeft,
                padding: EdgeInsets.fromLTRB(20, 5, 15, 5),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                          alignment: FractionalOffset.centerLeft,
                          child: TextFormField(
                            autofocus: true,
                            focusNode: searchFocus,
                            cursorColor: Colors.black,
                            controller: textSearchController,
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            maxLength: 30,
                            textInputAction: TextInputAction.done,
                            onChanged: (value) {},
                            onFieldSubmitted: (value) {
                              print("$value");
                              searchFocus.unfocus();
                              setState(() {
                                searchKey = value;
                              });
                              getFilteredList(value);
                            },
                            style: TextStyle(
                                fontFamily: 'roboto',
                                fontSize: 13.0,
                                height: 1.5,
                                wordSpacing: 4,
                                color: Colors.grey),
                            decoration: new InputDecoration(
                                hintStyle: TextStyle(
                                    fontFamily: 'roboto',
                                    fontSize: 12.0,
                                    color: Colors.grey),
                                counterText: "",
                                isDense: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 0, bottom: 5, top: 5, right: 5),
                                hintText: "Search"),
                          )),
                      flex: 1,
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
            flex: 1,
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }

  Widget _buildEmployeeList(List<EmployeeListModel> employeeList) {
    if (employeeList != null && employeeList.length > 0) {
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: employeeList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          EmployeeListModel employeeItem = employeeList[index];
          return _buildEmployeeListItem(employeeItem);
        },
      );
    } else {
      return _buildErrorWidget("No results found");
    }
  }

  Widget _buildEmployeeListItem(EmployeeListModel employeeItem) {
    return InkWell(
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 3,
        child: Container(
            color: employeeItem != null ? Colors.white : Colors.transparent,
            height: 125,
            margin: const EdgeInsets.only(top: 15),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildImageWidget(employeeItem),
                SizedBox(width: 15),
                buildDetailsWidget(employeeItem)
              ],
            )),
      ),
      splashColor: Colors.grey,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                EmployeeDetailScreen(itemDetail: employeeItem),
          ),
        );
      },
    );
  }

  Widget _buildLoadingWidget() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.white.withOpacity(0.8),
          child: Card(
            margin: EdgeInsets.all(10),
            elevation: 3,
            child: Container(
                color: Colors.transparent,
                height: 125,
                margin: const EdgeInsets.only(top: 15),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      child: ClipOval(),
                    ),
                    SizedBox(width: 15),
                    Container(
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 20,
                              color: Colors.grey,
                            ),
                            Container(
                              height: 20,
                              color: Colors.grey,
                            ),
                            Container(
                              height: 20,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        flex: 1,
                      ),
                    )
                  ],
                )),
          )),
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 60),
      physics: ScrollPhysics(),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Something went wrong",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'roboto',
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.grey,
            child: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: () {
              setState(() {
                employeeListBloc.getAllEmployees();
              });

            },
          )
        ],
      ),
    );
  }

  Widget buildImageWidget(EmployeeListModel employeeItem) {
    return Container(
      height: 80.0,
      width: 80.0,
      child: ClipOval(
          child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: employeeItem.profileImage != null
                  ? employeeItem.profileImage
                  : "",
              placeholder: (context, url) => Padding(
                    child: RoundedLoader(),
                    padding: EdgeInsets.all(10),
                  ),
              errorWidget: (context, url, error) => TextDrawableWidget(
                      getName(employeeItem.name), ColorGenerator.materialColors,
                      (bool selected) {
                    // on tap callback
                    print("on tap callback");
                  }, false, 110.0, 110.0, BoxShape.circle,
                      TextStyle(color: Colors.white, fontSize: 30.0)))),
    );
  }

  Widget buildDetailsWidget(EmployeeListModel employeeItem) {
    return Container(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildName(employeeItem),
            _buildPhone(employeeItem),
            _buildEmail(employeeItem),
          ],
        ),
        flex: 1,
      ),
    );
  }

  Widget _buildName(EmployeeListModel employeeItem) {
    return Container(
      child: Text(
        getName(employeeItem.name),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontFamily: 'roboto',
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.normal),
      ),
      margin: EdgeInsets.only(top: 5),
    );
  }

  void checkOfflineData() async {
    List<EmployeeListModel> list = await DBProvider.db.getAllEmployees();
    if (list.length > 0) {
      setState(() {
        hasData = true;
        hasFiltered = false;
      });
    }
  }

  void getFilteredList(String value) async {


    List<EmployeeListModel> list =
        await DBProvider.db.getAllFilteredList(value);
    if (list.length > 0) {
      setState(() {

        hasData = false;
        hasFiltered = true;
      });
    }
  }
}

Widget _buildEmail(EmployeeListModel employeeItem) {
  return Container(
    child: Text(
      getEmail(employeeItem.email),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontFamily: 'roboto',
          color: Colors.grey,
          fontSize: 12.0,
          fontWeight: FontWeight.normal),
    ),
    margin: EdgeInsets.only(bottom: 10),
  );
}

Widget _buildPhone(EmployeeListModel employeeItem) {
  return Container(
    child: Text(
      getPhone(employeeItem.phone),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontFamily: 'roboto',
          color: Colors.grey,
          fontSize: 12.0,
          fontWeight: FontWeight.normal),
    ),
    margin: EdgeInsets.only(bottom: 5, top: 5),
  );
}

getImage(String image) {
  String img = "";
  if (image != null) {
    img = image;
  }
  return img;
}

getName(String empName) {
  String name = "";
  if (empName != null) {
    name = CommonMethods().titleCase(empName);
  }
  return name;
}

getPhone(String empPhone) {
  String phone = "--- --- ----- -----";
  if (empPhone != null) {
    phone = empPhone;
  }
  return phone;
}

getEmail(String empMail) {
  String mail = "";
  if (empMail != null) {
    mail = empMail;
  }
  return mail;
}
