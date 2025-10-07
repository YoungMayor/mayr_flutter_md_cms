import 'package:flutter/material.dart';

/// Type definition for internal action handlers.
///
/// Maps internal action identifiers (e.g., 'internal:action_name')
/// to callback functions that receive a BuildContext.
///
/// Example:
/// ```dart
/// InternalActions actions = {
///   'internal:navigate_home': (context) => Navigator.pushNamed(context, '/home'),
///   'internal:show_dialog': (context) => showDialog(...),
/// };
/// ```
typedef InternalActions = Map<String, Function(BuildContext)>;
