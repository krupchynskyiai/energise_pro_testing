import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:get_ip_address/get_ip_address.dart';

import 'package:latlong2/latlong.dart';

class IPLocation extends StatefulWidget {
  IPLocation({super.key});

  IPLocationState createState() => IPLocationState();
}

class IPLocationState extends State<IPLocation> {
  var fetchResult;
  bool isLoading = true;

  void initState() {
    super.initState();

    main();
  }

  void main() async {
    print('here');
    try {
      /// Initialize Ip Address
      final ipAddress = IpAddress(type: RequestType.json);

      /// Get the IpAddress based on requestType.
      dynamic data = await ipAddress.getIpAddress();
      fetchData(data['ip']);
    } on IpAddressException catch (exception) {
      /// Handle the exception.
      print(exception.message);
    }
  }

  Future fetchData(ipAddress) async {
    final response =
        await http.get(Uri.parse('http://ip-api.com/json/$ipAddress'));
    fetchResult = jsonDecode(response.body);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _refresh() {
    main();
    return Future.delayed(Duration(seconds: 2));
  }

  Widget build(BuildContext context) {
    return isLoading
        ? Text('Loading')
        : Container(
            height: 500,
            width: double.infinity,
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter:
                              LatLng(fetchResult['lat'], fetchResult['lon']),
                          initialZoom: 9.2,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(
                                    fetchResult['lat'], fetchResult['lon']),
                                width: 50,
                                height: 50,
                                child: SvgPicture.asset(
                                    'assets/icons/geolocation.svg'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Text('Country - ${fetchResult['country']}'),
                    Text('Country Code - ${fetchResult['countryCode']}'),
                    Text('Region - ${fetchResult['region']}'),
                    Text('Country Code - ${fetchResult['regionName']}'),
                    Text('Country Code - ${fetchResult['city']}'),
                    Text('Country Code - ${fetchResult['zip']}'),
                    Text('Country Code - ${fetchResult['lat']}'),
                    Text('Country Code - ${fetchResult['lon']}'),
                    Text('Country Code - ${fetchResult['timezone']}'),
                    Text('Country Code - ${fetchResult['isp']}'),
                    Text('Country Code - ${fetchResult['org']}'),
                    Text('Country Code - ${fetchResult['as']}'),
                    Text('Country Code - ${fetchResult['query']}'),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });

                          main();
                        },
                        child: Text('Refresh'))
                  ],
                ),
              ),
            ));
  }
}
