import 'package:hormoniousflo/data/services/api.dart';
import 'package:hormoniousflo/data/models/api_response.dart';

Api _helper = Api();

/// A wrapper that handles communication between the api class and controllers
class PhaseRepositoy {
  Future<ApiResponse> getPhases(
    String periodDate,
    String periodLength,
    String cycleLength,
  ) async {
    final body = {
      "lmpp": periodDate,
      "cycle": cycleLength,
      "periodLen": periodLength,
    };
    return await _helper.postData('/cycle-info', body, hasHeader: true);
  }
}
