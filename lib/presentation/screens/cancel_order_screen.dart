
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/data/models/order.dart';

import '../../../data/services/order_services.dart';

class CancelOrderScreen extends StatefulWidget {
  final OrderItem order;

  const CancelOrderScreen({super.key, required this.order});

  @override
  State<CancelOrderScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  String? selectedReason;
  final TextEditingController _otherReasonController = TextEditingController();
  bool _isSubmitting = false;

  final List<String> cancellationReasons = [
    'Waiting for long time',
    'Unable to contact driver',
    'Driver denied to go to destination',
    'Driver denied to come to pickup',
    'Wrong address shown',
    'The price is not reasonable',
    'I want to order another restaurant',
    'I just want to cancel',
  ];

  @override
  void dispose() {
    _otherReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color darkBackground = Color(0xFF141414);
    const Color cardColor = Color(0xFF1F1F1F);
    const Color primaryGreen = Color(0xFF4CAF50);
    final bool isOthersSelected = selectedReason != null && !cancellationReasons.contains(selectedReason);

    return Scaffold(
      backgroundColor: darkBackground,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Cancel Order',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please select the reason for cancellation:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFF424242)),
                  ...cancellationReasons.map((reason) => _buildReasonTile(reason, cardColor, primaryGreen)),
                  const SizedBox(height: 24),
                  const Text(
                    'Others',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _otherReasonController,
                    style: const TextStyle(color: Colors.white),
                    minLines: 1,
                    maxLines: 6,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Others reason...',
                      hintStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: isOthersSelected
                            ? const BorderSide(color: primaryGreen, width: 1.5)
                            : BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          selectedReason = value;
                        } else if (isOthersSelected) {
                          selectedReason = null;
                        }
                      });
                    },
                    onTap: () {
                      setState(() {
                        if (_otherReasonController.text.isEmpty) {
                          selectedReason = 'Others';
                        } else {
                          selectedReason = _otherReasonController.text;
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _canSubmit() ? _submitCancellation : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  disabledBackgroundColor: const Color(0xFF505050),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildReasonTile(String reason, Color cardColor, Color primaryGreen) {
    return RadioListTile<String>(
      value: reason,
      activeColor:primaryGreen,
      groupValue: selectedReason,
      onChanged: (String? value) {
        setState(() {
          selectedReason = value;
          _otherReasonController.clear();
        });
      },
      contentPadding: EdgeInsets.zero,

      title: Text(
        reason,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  bool _canSubmit() {
    return selectedReason != null && selectedReason!.isNotEmpty && !_isSubmitting;
  }

  Future<void> _submitCancellation() async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      await OrderServices.cancelOrder(widget.order);

      if (mounted) {
        Navigator.pop(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showCancellationConfirmation();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error cancelling order: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showCancellationConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF2A2A2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/sad_emoji.png',
                  height: 120,
                  width: 120,
                ),
                const SizedBox(height: 16),
                const Text(
                  "We're so sad about your cancellation",
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'We will continue to improve our service & satisfy you on the next order.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
