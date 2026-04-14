import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

class NearestScreen extends StatefulWidget {
  const NearestScreen({super.key});

  @override
  State<NearestScreen> createState() => _NearestScreenState();
}

class _NearestScreenState extends State<NearestScreen> {
  String? nearestRestaurant;

  Future<void> _findNearest() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(() {
        nearestRestaurant = "Location permission denied.";
      });
      return;
    }

    await Geolocator.getCurrentPosition();

    final places = [
      "Chengdu",
      "Paris",
      "Rome",
      "Casablanca",
      "New York",
      "Tokyo",
    ];
    final randomPlace = places[Random().nextInt(places.length)];

    setState(() {
      nearestRestaurant = "$randomPlace Italiano Restaurant";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearest Italiano")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (nearestRestaurant == null)
              ElevatedButton(
                onPressed: _findNearest,
                child: const Text("Allow Location"),
              )
            else
              Text(
                "Nearest: $nearestRestaurant",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
