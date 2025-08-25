import 'package:flutter/material.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import '../../../shared/responsive/screen.dart';

class MissionCard extends StatefulWidget {
  final String title;
  // final String description;
  final String status;
  final String interventionType;
  final String networkType;
  // final String creationDate;
  final List<String> streets;
  final List<String> neighborhoods;
  final String municipality;
  final Color statusColor;
  final Color typeColor;
  final VoidCallback? onTap;

  const MissionCard({
    super.key,
    required this.title,
    // required this.description,
    required this.status,
    required this.interventionType,
    required this.networkType,
    // required this.creationDate,
    required this.streets,
    required this.neighborhoods,
    required this.municipality,
    required this.statusColor,
    required this.typeColor,
    this.onTap,
  });

  @override
  State<MissionCard> createState() => _MissionCardState();
}

class _MissionCardState extends State<MissionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _truncateDescription(String text, bool isMobile) {
    final maxLength = isMobile ? 30 : 60;
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final textScale = MediaQuery.of(context).textScaleFactor;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 2),
              )
            ],
            border: Border.all(
              color: context.colorScheme.primary,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and badges
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildBadge(widget.status, widget.statusColor),
                              const SizedBox(width: 8),
                              _buildBadge(
                                  widget.interventionType, widget.typeColor),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title à gauche
                          Expanded(
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Badges à droite
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              _buildBadge(widget.status, widget.statusColor),
                              _buildBadge(
                                  widget.interventionType, widget.typeColor),
                            ],
                          ),
                        ],
                      ),
              ),

              // Divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey[300],
                ),
              ),

              // Details section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(Icons.public, 'Réseau', widget.networkType),
                    const SizedBox(height: 6),
                    // _buildDetailRow(
                    //     Icons.calendar_today, 'Créée le', widget.creationDate),
                    const SizedBox(height: 6),
                    if (widget.streets.isNotEmpty)
                      _buildDetailRow(
                          Icons.place, 'Rues', widget.streets.join(', ')),
                    // if (widget.neighborhoods.isNotEmpty)
                    //   _buildDetailRow(Icons.location_city, 'Quartiers',
                    //       widget.neighborhoods.join(', ')),
                    if (widget.municipality.isNotEmpty)
                      _buildDetailRow(
                          Icons.apartment, 'Commune', widget.municipality),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey[500]),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: '$label : ',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleTapDown(TapDownDetails details) {
    if (!_isPressed) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (_isPressed) {
      setState(() => _isPressed = false);
      _controller.reverse();
      widget.onTap?.call();
    }
  }

  void _handleTapCancel() {
    if (_isPressed) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }
}



// import 'package:flutter/material.dart';


// import '../../../shared/responsive/screen.dart';


// class Cart extends StatefulWidget {
//   final String title;
//   final String date;
//   final String time;
//   final String type;
//   final String networkType;
//   final Color badgeColor;
//   final bool isCompleted;
//   final VoidCallback? onTap;

//   const Cart({
//     super.key,
//     required this.title,
//     required this.networkType,
//     required this.date,
//     required this.time,
//     required this.type,
//     required this.badgeColor,
//     this.isCompleted = false,
//     this.onTap,
//   });

//   @override
//   State<Cart> createState() => _CartState();
// }

// class _CartState extends State<Cart> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   bool _isPressed = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 150),
//       vsync: this,
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _handleTapDown(TapDownDetails details) {
//     if (!_isPressed) {
//       _isPressed = true;
//       _controller.forward();
//     }
//   }

//   void _handleTapUp(TapUpDetails details) {
//     if (_isPressed) {
//       _isPressed = false;
//       _controller.reverse();
//       widget.onTap?.call();
//     }
//   }

//   void _handleTapCancel() {
//     if (_isPressed) {
//       _isPressed = false;
//       _controller.reverse();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: _handleTapDown,
//       onTapUp: _handleTapUp,
//       onTapCancel: _handleTapCancel,
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: Container(
//           margin: EdgeInsets.symmetric(
//             horizontal: hauteur(context, 0),
//             vertical: hauteur(context, 4),
//           ),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(hauteur(context, 5)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.1),
//                 spreadRadius: 1,
//                 blurRadius: hauteur(context, 6),
//                 offset: const Offset(0, 1),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.fromLTRB(
//                   hauteur(context, 16),
//                   hauteur(context, 16),
//                   hauteur(context, 16),
//                   hauteur(context, 8),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         widget.title,
//                         style: TextStyle(
//                           fontSize: hauteur(context, 12),
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: hauteur(context, 16),
//                         vertical: hauteur(context, 8),
//                       ),
//                       decoration: BoxDecoration(
//                         color: widget.badgeColor.withOpacity(0.2),
//                         borderRadius:
//                         BorderRadius.circular(hauteur(context, 24)),
//                       ),
//                       child: Text(
//                         widget.type,
//                         style: TextStyle(
//                           color: widget.badgeColor,
//                           fontSize: hauteur(context, 10),
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(
//                   hauteur(context, 16),
//                   hauteur(context, 8),
//                   hauteur(context, 16),
//                   hauteur(context, 16),
//                 ),
//                 child: Row(
//                   children: [
//                     Text(
//                       "Type de réseau : ",
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: hauteur(context, 11),
//                       ),
//                     ),
//                     Text(
//                       widget.networkType,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: hauteur(context, 11),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.fromLTRB(
//                   hauteur(context, 16),
//                   hauteur(context, 8),
//                   hauteur(context, 16),
//                   hauteur(context, 16),
//                 ),
//                 child: Row(
//                   children: [
//                     Text(
//                       "On : ",
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: hauteur(context, 14),
//                       ),
//                     ),
//                     Text(
//                       widget.date,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: hauteur(context, 10),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const Spacer(),
//                     Icon(
//                       widget.isCompleted
//                           ? Icons.check_circle
//                           : Icons.remove_circle,
//                       color: widget.isCompleted ? Colors.green : Colors.blue,
//                       size: hauteur(context, 24),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
