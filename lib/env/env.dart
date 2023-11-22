import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY')
  static const String apiKey = _Env.apiKey;
  @EnviedField(varName: 'ASSEMBLY_AI_API_KEY')
  static const String assemblyApiKey = _Env.assemblyApiKey;
}