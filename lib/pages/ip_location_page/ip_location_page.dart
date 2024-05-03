import 'dart:convert';
import 'package:energise_pro_testing/components/button.dart';
import 'package:energise_pro_testing/components/loader.dart';
import 'package:energise_pro_testing/pages/ip_location_page/api_info_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:get_ip_address/get_ip_address.dart';
import 'package:latlong2/latlong.dart';

class IPLocation extends StatefulWidget {
  const IPLocation({super.key});

  @override
  IPLocationState createState() => IPLocationState();
}

class IPLocationState extends State<IPLocation> {
  dynamic fetchResult;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    main();
  }

  void main() async {
    try {
      const cacheKey = 'ip_address';

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
          maxAge: const Duration(minutes: 5),
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
      final response = await http.get(Uri.parse('http://ip-api.com/json/'));
      fetchResult = jsonDecode(response.body);
      await DefaultCacheManager().putFile(cacheKey, response.bodyBytes,
          maxAge: const Duration(minutes: 5));
      print('got from api');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _refresh() {
    main();
    return Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: <Color>[
                  Color(0xff1f005c),
                  Color(0xff5b0060),
                  Color(0xff870160),
                  Color(0xffac255e),
                  Color(0xffca485c),
                  Color(0xffe16b5c),
                  Color(0xfff39060),
                  Color(0xffffb56b),
                ],
              ),
            ),
            child: const Loader())
        : Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 1),
                colors: <Color>[
                  Color(0xff1f005c),
                  Color(0xff5b0060),
                  Color(0xff870160),
                  Color(0xffac255e),
                  Color(0xffca485c),
                  Color(0xffe16b5c),
                  Color(0xfff39060),
                  Color(0xffffb56b),
                ],
              ),
            ),
            width: double.infinity,
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: Column(
                children: [
                  SizedBox(
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
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ApiInfoFormater(apiResponse: fetchResult),
                  ),
                  const SizedBox(height: 25),
                  ButtonTemplate(
                      linkOrText: 'assets/icons/refresh.svg',
                      isImage: true,
                      functionGot: () {
                        setState(() {
                          isLoading = true;
                        });

                        main();
                      })
                ],
              ),
            ));
  }
}
