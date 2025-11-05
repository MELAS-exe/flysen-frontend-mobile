// import 'package:flutter/material.dart';
// import 'package:flysen_frontend_mobile/core/presentation/widgets/custom_button.dart';
// import 'package:flysen_frontend_mobile/core/presentation/widgets/stars.dart';
// import 'package:flysen_frontend_mobile/core/presentation/widgets/top_bar.dart';
// import 'package:flysen_frontend_mobile/features/discover/presentation/widgets/hotel_proximity.dart';
//
// class DestinationDetail extends StatelessWidget {
//   final bool isEvent;
//   final bool isHotel;
//   DestinationDetail({this.isEvent = false, this.isHotel = false});
//   @override
//   Widget build(BuildContext context) {
//
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           alignment: Alignment.topCenter,
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 40),
//                   Stack(
//                     children: [
//                       Container(
//                         width: MediaQuery.of(context).size.width - 40,
//                         height: MediaQuery.of(context).size.width - 40,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(15),
//                           child:
//                               isHotel
//                                   ? selectedHotel?.mainImage == null
//                                       ? Container(
//                                         color: Colors.grey,
//                                         child: Center(
//                                           child: SizedBox(
//                                             height: 100,
//                                             child: Image.asset(
//                                               "assets/image.png",
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                       : Image.network(
//                                         selectedHotel!.mainImage!,
//                                         fit: BoxFit.fill,
//                                       )
//                                   : selectedDestination?.image1 == null
//                                   ? Container(
//                                     color: Colors.grey,
//                                     child: Center(
//                                       child: SizedBox(
//                                         height: 100,
//                                         child: Image.asset("assets/image.png"),
//                                       ),
//                                     ),
//                                   )
//                                   : Image.network(
//                                     selectedDestination!.image1!,
//                                     fit: BoxFit.fill,
//                                   ),
//                         ),
//                       ),
//                       isEvent
//                           ? Positioned(
//                             right: 20,
//                             bottom: 20,
//                             child: Container(
//                               width: 150,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(100),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   "2 jours restants",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                           : SizedBox(),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   SizedBox(
//                     width: MediaQuery.sizeOf(context).width - 40,
//                     child: Text(
//                       isHotel? selectedHotel?.name ?? "Nom de l'hôtel" :
//                       selectedDestination?.nom ?? "Nom de la destination",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.sizeOf(context).width - 40,
//                     child: Stars(
//                       score:
//                           isHotel ? selectedHotel?.stars?.toDouble() ?? 0.0 :
//                           selectedDestination?.nombreEtoiles.toDouble() ?? 0.0,
//                       showContainer: false,
//                     ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.sizeOf(context).width - 40,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             !isHotel
//                                 ? SizedBox(
//                                   width: 20,
//                                   child: Image.asset("assets/modeavionon.png"),
//                                 )
//                                 : SizedBox(),
//                             !isHotel ? SizedBox(width: 10) : SizedBox(),
//                             !isHotel
//                                 ? Text(
//                                   "${selectedDestination?.heureVoyage.toString()} heures" ??
//                                       "N/A",
//                                   style: TextStyle(fontSize: 12),
//                                 )
//                                 : SizedBox(),
//                             !isHotel ? SizedBox(width: 20) : SizedBox(),
//                             !isHotel
//                                 ? SizedBox(
//                                   width: 20,
//                                   child: Image.asset("assets/ticket.png"),
//                                 )
//                                 : SizedBox(),
//                             !isHotel ? SizedBox(width: 10) : SizedBox(),
//                             !isHotel
//                                 ? Text(
//                                   "${selectedDestination?.prix ?? 'N/A'} F CFA",
//                                   style: TextStyle(fontSize: 12),
//                                 )
//                                 : SizedBox(),
//                             isHotel
//                                 ? SizedBox(
//                                   width: 20,
//                                   child: Image.asset("assets/lit.png"),
//                                 )
//                                 : SizedBox(),
//                             isHotel ? SizedBox(width: 10) : SizedBox(),
//                             isHotel
//                                 ? Text(
//                                   "${selectedHotel?.pricePerNight ?? 'N/A'} FCFA par nuit",
//                                   style: TextStyle(fontSize: 12),
//                                 )
//                                 : SizedBox(),
//                           ],
//                         ),
//                         CustomButton(
//                           width: 100,
//                           height: 30,
//                           fontSize: 14,
//                           text: "Réserver",
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Container(
//                     width: MediaQuery.sizeOf(context).width - 40,
//                     height: 1,
//                     color: Colors.grey,
//                   ),
//                   SizedBox(height: 20),
//                   SizedBox(
//                     width: MediaQuery.sizeOf(context).width - 40,
//                     child: Text(
//                       isHotel
//                           ? "Description de l'hôtel"
//                           : selectedDestination?.description ??
//                       selectedDestination?.description ??
//                           "Aucune description disponible.",
//                       style: TextStyle(fontSize: 12),
//                     ),
//                   ),
//                   SizedBox(height: 40),
//                   SizedBox(
//                     width: MediaQuery.sizeOf(context).width - 40,
//                     child: Text(
//                       isHotel
//                           ? "Services de l'hôtel"
//                           : selectedDestination?.hotelsProches != null &&
//                               selectedDestination!.hotelsProches!.isNotEmpty
//                           ? "Hôtels à proximité"
//                           : "Aucun hôtel à proximité",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width,
//                     child:
//                         (selectedDestination?.hotelsProches != null &&
//                                     selectedDestination!
//                                         .hotelsProches!
//                                         .isNotEmpty &&
//                                     !isHotel) ||
//                                 (selectedDestination!
//                                             .hotelsProches![0]
//                                             ?.servicePhotos !=
//                                         null &&
//                                     selectedDestination!
//                                         .hotelsProches![0]!
//                                         .servicePhotos!
//                                         .isNotEmpty &&
//                                     isHotel)
//                             ? SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 children: [
//                                   if (!isHotel &&
//                                       selectedDestination?.hotelsProches !=
//                                           null)
//                                     ...selectedDestination!.hotelsProches!.map((
//                                       hotel,
//                                     ) {
//                                       return Padding(
//                                         padding: const EdgeInsets.only(
//                                           left: 20.0,
//                                         ),
//                                         child: HotelProximity(
//                                           logo: Image.asset(
//                                             "assets/RadissonLogo.png",
//                                             width: 100,
//                                           ),
//                                           // logo: hotel.logo != null ? Image.network(hotel.logo!) : Image.asset("assets/image.png"),
//                                           onTap: () {
//                                             destinationViewModel.selectHotel(hotel);
//                                             Navigator.pushNamed(
//                                               context,
//                                               "/hotel_detail",
//                                             );
//                                           },
//                                           image:
//                                               hotel.mainImage != null
//                                                   ? Image.network(
//                                                     hotel.mainImage!,
//                                                     fit: BoxFit.cover,
//                                                   )
//                                                   : Image.asset(
//                                                     "assets/image.png",
//                                                   ),
//                                           score: hotel.stars?.toDouble() ?? 0.0,
//                                         ),
//                                       );
//                                     }).toList(),
//                                   if (isHotel &&
//                                       selectedDestination.hotelsProches !=
//                                           null &&
//                                       selectedDestination
//                                               .hotelsProches![0]
//                                               .servicePhotos !=
//                                           null)
//                                     ...selectedDestination
//                                         .hotelsProches![0]
//                                         .servicePhotos!
//                                         .map((service) {
//                                           return Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 20.0,
//                                             ),
//                                             child: HotelServices(
//                                               image:
//                                                   service['image'] != null
//                                                       ? Image.network(
//                                                         service['image'],
//                                                         fit: BoxFit.fill,
//                                                       )
//                                                       : Image.asset(
//                                                         "assets/image.png",
//                                                       ),
//                                             ),
//                                           );
//                                         })
//                                         .toList(),
//                                   SizedBox(width: 20),
//                                 ],
//                               ),
//                             )
//                             : SizedBox.shrink(),
//                   ),
//                   SizedBox(height: 40),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 40),
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: TopBar(showBack: true),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
