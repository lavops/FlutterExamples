import 'package:dio/dio.dart';
import 'package:repoviewer/core/infrastructure/remote_response.dart';
import 'package:repoviewer/github/core/infrastructure/github_repo_dto.dart';

class StarredReposRemoteService {
  final Dio _dio;

  StarredReposRemoteService(this._dio);

  Future<RemoteResponse<List<GithubRepoDTO>>> getStarredReposPage(
    int page,
  ) async {}
}
