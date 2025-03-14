import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fixtures_web_scraping/features/fixtures/data/data_sources/fixtures_remote_data_src.dart';
import 'package:fixtures_web_scraping/features/fixtures/domain/repositories/fixtures_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    FixturesRepository,
    http.Client,
    FixturesRemoteDataSource,
    Connectivity,
  ],
)
void main() {}
