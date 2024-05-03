import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApiInfoFormater extends StatelessWidget {
  ApiInfoFormater({super.key, required this.apiResponse});
  dynamic apiResponse;

  Widget build(BuildContext context) {
    dynamic keys = [
      '${AppLocalizations.of(context)!.country}',
      '${AppLocalizations.of(context)!.countryCode}',
      '${AppLocalizations.of(context)!.region}',
      '${AppLocalizations.of(context)!.regionName}',
      '${AppLocalizations.of(context)!.city}',
      '${AppLocalizations.of(context)!.zip}',
      '${AppLocalizations.of(context)!.latitude}',
      '${AppLocalizations.of(context)!.longitude}',
      '${AppLocalizations.of(context)!.timezone}',
      '${AppLocalizations.of(context)!.isp}',
      '${AppLocalizations.of(context)!.organization}',
      '${AppLocalizations.of(context)!.as}',
      '${AppLocalizations.of(context)!.query}'
    ];
    dynamic apiValues = [
      'country',
      'countryCode',
      'region',
      'regionName',
      'city',
      'zip',
      'lat',
      'lon',
      'timezone',
      'isp',
      'org',
      'as',
      'query'
    ];
    return ListView(
      children: [
        for (var i = 0; i < apiValues.length; i++)
          Text(
            '${keys[i]} - ${apiResponse[apiValues[i]]}',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}
