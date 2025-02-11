import 'package:injectable/injectable.dart';

import '../../../../core/services/database/local_database_service.dart';

abstract class {{feature.pascalCase()}}LocalDataSource {}

@LazySingleton(as: {{feature.pascalCase()}}LocalDataSource)
class {{feature.pascalCase()}}LocalDataSourceImplementation implements {{feature.pascalCase()}}LocalDataSource {
  final LocalDatabaseService _localDatabase;
  
  {{feature.pascalCase()}}LocalDataSourceImplementation({
    required LocalDatabaseService localDatabase,
  }) : _localDatabase = localDatabase;
}
