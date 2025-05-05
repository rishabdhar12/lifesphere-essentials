// lib/modules/budgeting_app/features/core/data/services/firestore_service.dart
import 'package:fpdart/fpdart.dart';
import 'package:lifesphere_essentials/core/error/failure.dart';

abstract class FirestoreService {
  Future<Either<Failure, void>> createDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  });

  Future<Either<Failure, Map<String, dynamic>>> getDocument({
    required String collectionPath,
    required String docId,
  });

  Future<Either<Failure, List<Map<String, dynamic>>>> getCollection({
    required String collectionPath,
  });

  Future<Either<Failure, void>> updateDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  });

  Future<Either<Failure, void>> deleteDocument({
    required String collectionPath,
    required String docId,
  });
}
