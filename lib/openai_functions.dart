import 'package:dart_openai/dart_openai.dart';

List<OpenAIToolModel> openAIFunctions = [
  OpenAIToolModel(
    type: "function",
    function: OpenAIFunctionModel.withParameters(
      name: 'get_business_name',
      parameters: [
        OpenAIFunctionProperty.string(
          name: 'name',
          description: 'Nombre que usa el negocio para identificarse.',
          isRequired: true,
        )
      ],
    )
  )
];


