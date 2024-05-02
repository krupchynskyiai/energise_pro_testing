import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:get_ip_address/get_ip_address.dart';

import 'package:latlong2/latlong.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      final cacheKey = 'ip_address';

      FileInfo? fileInfo =
          await DefaultCacheManager().getFileFromCache(cacheKey);

      if (fileInfo != null && fileInfo.validTill.isAfter(DateTime.now())) {
        dynamic cachedData = jsonDecode(await fileInfo.file.readAsString());
        fetchData(cachedData['ip']);
      } else {
        final ipAddress = IpAddress(type: RequestType.json);
        dynamic data = await ipAddress.getIpAddress();
        fetchData(data['ip']);

        await DefaultCacheManager().putFile(
          cacheKey,
          utf8.encode(jsonEncode(data)),
          maxAge: Duration(minutes: 5),
        );
      }
    } on IpAddressException catch (exception) {
      print(exception.message);
    }
  }

  Future fetchData(ipAddress) async {
    String cacheKey = 'ip_location_$ipAddress';
    FileInfo? fileInfo = await DefaultCacheManager().getFileFromCache(cacheKey);
    if (fileInfo != null && fileInfo.validTill.isAfter(DateTime.now())) {
      fetchResult = jsonDecode(await fileInfo.file.readAsString());
      print('got from cache');
      setState(() {
        isLoading = false;
      });
    } else {
      final ipAddress = IpAddress(type: RequestType.json);
      dynamic data = await ipAddress.getIpAddress();
      final response =
          await http.get(Uri.parse('http://ip-api.com/json/${data}'));
      fetchResult = jsonDecode(response.body);
      await DefaultCacheManager()
          .putFile(cacheKey, response.bodyBytes, maxAge: Duration(minutes: 5));
      print('got from api');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _refresh() {
    main();
    return Future.delayed(Duration(seconds: 2));
  }

  Widget build(BuildContext context) {
    return isLoading
        ? Text(AppLocalizations.of(context)!.loading)
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
                    Text(
                        '${AppLocalizations.of(context)!.country} -${fetchResult['country']}'),
                    Text(
                        '${AppLocalizations.of(context)!.countryCode} - ${fetchResult['countryCode']}'),
                    Text(
                        '${AppLocalizations.of(context)!.region} - ${fetchResult['region']}'),
                    Text(
                        '${AppLocalizations.of(context)!.regionName} - ${fetchResult['regionName']}'),
                    Text(
                        '${AppLocalizations.of(context)!.city} - ${fetchResult['city']}'),
                    Text(
                        '${AppLocalizations.of(context)!.zip} - ${fetchResult['zip']}'),
                    Text(
                        '${AppLocalizations.of(context)!.latitude} - ${fetchResult['lat']}'),
                    Text(
                        '${AppLocalizations.of(context)!.longitude} - ${fetchResult['lon']}'),
                    Text(
                        '${AppLocalizations.of(context)!.timezone} - ${fetchResult['timezone']}'),
                    Text(
                        '${AppLocalizations.of(context)!.isp} - ${fetchResult['isp']}'),
                    Text(
                        '${AppLocalizations.of(context)!.organization} - ${fetchResult['org']}'),
                    Text(
                        '${AppLocalizations.of(context)!.as} - ${fetchResult['as']}'),
                    Text(
                        '${AppLocalizations.of(context)!.query} - ${fetchResult['query']}'),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });

                          main();
                        },
                        child: Text('${AppLocalizations.of(context)!.refresh}'))
                  ],
                ),
              ),
            ));
  }
}
