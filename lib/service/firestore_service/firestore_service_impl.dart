// lib/modules/budgeting_app/features/core/data/services/firestore_service_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:lifesphere_essentials/core/error/failure.dart';
import 'package:lifesphere_essentials/service/firestore_service/firestore_service.dart';

@Injectable(as: FirestoreService)
class FirestoreServiceImpl implements FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreServiceImpl(this._firestore);

  @override
  Future<Either<Failure, void>> createDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).set(data);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(Failure(e.message ?? 'Firestore operation failed'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getDocument({
    required String collectionPath,
    required String docId,
  }) async {
    try {
      final doc = await _firestore.collection(collectionPath).doc(docId).get();

      if (!doc.exists) {
        return Left(Failure('Document not found'));
      }

      return Right(doc.data()!);
    } on FirebaseException catch (e) {
      return Left(Failure(e.message ?? 'Firestore operation failed'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getCollection({
    required String collectionPath,
  }) async {
    try {
      final query = await _firestore.collection(collectionPath).get();

      return Right(query.docs.map((doc) => doc.data()).toList());
    } on FirebaseException catch (e) {
      return Left(Failure(e.message ?? 'Firestore operation failed'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).update(data);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(Failure(e.message ?? 'Firestore operation failed'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDocument({
    required String collectionPath,
    required String docId,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).delete();
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(Failure(e.message ?? 'Firestore operation failed'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
