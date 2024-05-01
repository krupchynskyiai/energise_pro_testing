import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_ip_address/get_ip_address.dart';

class IPLocation extends StatefulWidget {
  IPLocation({super.key});

  IPLocationState createState() => IPLocationState();
}

class IPLocationState extends State<IPLocation> {
  var fetchResult;

  void initState() {
    super.initState();

    main();
  }

  void main() async {
    try {
      /// Initialize Ip Address
      var ipAddress = IpAddress(type: RequestType.json);

      /// Get the IpAddress based on requestType.
      dynamic data = await ipAddress.getIpAddress();
      print(data['ip']);
      fetchData(data['ip']);
    } on IpAddressException catch (exception) {
      /// Handle the exception.
      print(exception.message);
    }
  }

  Future fetchData(ipAddress) async {
    print('fetching started');
    final response =
        await http.get(Uri.parse('http://ip-api.com/json/$ipAddress'));
    print('http://ip-api.com/json/$ipAddress');
    print(jsonDecode(response.body)['country']);
  }

  Widget build(BuildContext context) {
    return Text('Response ');
  }
}
