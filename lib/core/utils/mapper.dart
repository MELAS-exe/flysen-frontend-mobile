/// A private constant map that holds the mapping between a carrier's IATA code
/// and the local asset path for its logo.
const Map<String, String> _carrierLogoMap = {
  'AT': 'assets/images/square/AT.png',
  'AH': 'assets/images/square/AH.png',
  'AF': 'assets/images/square/AF.png',
  'TK': 'assets/images/square/TK.png',
  'SN': 'assets/images/square/SN.png',
  'IB': 'assets/images/square/IB.png',
  'LH': 'assets/images/square/LH.png',
};

/// The asset path for a default/placeholder logo to be used when a specific
/// airline's logo is not available in the map.
const String _defaultLogoPath = 'assets/icons/app-logo.png';

/// Retrieves the logo asset path for a given airline carrier code.
///
/// [carrierCode] The two-letter IATA code of the airline (e.g., "AT").
///
/// Returns the asset path as a [String]. If the carrier code is not found in
/// the map, it returns the path to a default placeholder logo.
String getAirlineLogoPath(String carrierCode) {
  return _carrierLogoMap[carrierCode] ?? _defaultLogoPath;
}