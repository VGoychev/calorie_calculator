import 'package:flutter/material.dart';

class TermsBottomSheet extends StatefulWidget {
  const TermsBottomSheet({super.key});

  @override
  State<TermsBottomSheet> createState() => _TermsBottomSheetState();

  static Future<bool?> show(BuildContext context) async {
    return await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => const TermsBottomSheet(),
    );
  }
}

class _TermsBottomSheetState extends State<TermsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '''
  1. Acceptance of Terms
  By using this application, you agree to be bound by these terms and conditions.

  2. Use of Service
  You may use our service for lawful purposes only.

  3. Privacy Policy
  Your privacy is important to us. Please review our Privacy Policy.

  4. User Content
  You are responsible for any content you post or transmit through the service.

  5. Disclaimer
  The service is provided "as is" without any warranties, express or implied.

  6. Limitation of Liability
  In no event shall we be liable for any indirect, incidental, special, consequential, or punitive damages.

  7. Changes to Terms
  We reserve the right to modify these terms at any time.

  8. Governing Law
  These terms shall be governed by and construed in accordance with applicable laws.

  For questions about these terms, please contact our support team.
                        ''',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 32, 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Accept',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Close',
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
