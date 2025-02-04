import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileAvatar extends StatelessWidget {
  final File profileImage; // Path to the profile image
  final String borderSvg; // Path to the custom SVG border
  final double size; // Size of the avatar

  const ProfileAvatar({
    super.key,
    required this.profileImage,
    required this.borderSvg,
    this.size = 90,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Profile Picture
          ClipOval(
            child: Image.file(
              profileImage,
              width: size - 10, // Slightly smaller than the border
              height: size - 10,
              fit: BoxFit.fill,
            ),
          ),
          // Custom SVG Border
          Center(
            child: Transform.scale(
              scale: 1,
              child: SvgPicture.asset(
                borderSvg,
                width: size,
                height: size,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class HomepageProfileAvatar extends StatelessWidget {
  final Uint8List  profileImage; // Path to the profile image
  final String borderSvg; // Path to the custom SVG border
  final double size; // Size of the avatar

  const HomepageProfileAvatar({
    super.key,
    required this.profileImage,
    required this.borderSvg,
    this.size = 90,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Profile Picture
          ClipOval(
            child: Image.memory(
              profileImage,
              width: size - 10, // Slightly smaller than the border
              height: size - 10,
              fit: BoxFit.fill,
            ),
          ),
          // Custom SVG Border
          Center(
            child: Transform.scale(
              scale: 1,
              child: SvgPicture.asset(
                borderSvg,
                width: size,
                height: size,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
