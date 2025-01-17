// Faces Table Fields & Schema Queries
import 'package:photos/services/machine_learning/face_ml/face_filtering/face_filtering_constants.dart';

const facesTable = 'faces';
const fileIDColumn = 'file_id';
const faceIDColumn = 'face_id';
const faceDetectionColumn = 'detection';
const faceEmbeddingBlob = 'eBlob';
const faceScore = 'score';
const faceBlur = 'blur';
const isSideways = 'is_sideways';
const imageWidth = 'width';
const imageHeight = 'height';
const faceClusterId = 'cluster_id';
const mlVersionColumn = 'ml_version';

const createFacesTable = '''CREATE TABLE IF NOT EXISTS $facesTable (
  $fileIDColumn	INTEGER NOT NULL,
  $faceIDColumn  TEXT NOT NULL UNIQUE,
	$faceDetectionColumn	TEXT NOT NULL,
  $faceEmbeddingBlob BLOB NOT NULL,
  $faceScore  REAL NOT NULL,
  $faceBlur REAL NOT NULL DEFAULT $kLapacianDefault,
  $isSideways	INTEGER NOT NULL DEFAULT 0,
  $imageHeight	INTEGER NOT NULL DEFAULT 0,
  $imageWidth	INTEGER NOT NULL DEFAULT 0,
  $mlVersionColumn	INTEGER NOT NULL DEFAULT -1,
  PRIMARY KEY($fileIDColumn, $faceIDColumn)
  );
  ''';

const deleteFacesTable = 'DROP TABLE IF EXISTS $facesTable';
// End of Faces Table Fields & Schema Queries

//##region Face Clusters Table Fields & Schema Queries
const faceClustersTable = 'face_clusters';
const fcClusterID = 'cluster_id';
const fcFaceId = 'face_id';

// fcClusterId & fcFaceId are the primary keys and fcClusterId is a foreign key to faces table
const createFaceClustersTable = '''
CREATE TABLE IF NOT EXISTS $faceClustersTable (
  $fcFaceId	TEXT NOT NULL,
  $fcClusterID INTEGER NOT NULL,
  PRIMARY KEY($fcFaceId)
);
''';
// -- Creating a non-unique index on clusterID for query optimization
const fcClusterIDIndex =
    '''CREATE INDEX IF NOT EXISTS idx_fcClusterID ON $faceClustersTable($fcClusterID);''';
const dropFaceClustersTable = 'DROP TABLE IF EXISTS $faceClustersTable';
//##endregion

// People Table Fields & Schema Queries
const personTable = 'person';

const deletePersonTable = 'DROP TABLE IF EXISTS $personTable';
//End People Table Fields & Schema Queries

// Clusters Table Fields & Schema Queries
const clusterPersonTable = 'cluster_person';
const personIdColumn = 'person_id';
const clusterIDColumn = 'cluster_id';

const createClusterPersonTable = '''
CREATE TABLE IF NOT EXISTS $clusterPersonTable (
  $personIdColumn	TEXT NOT NULL,
  $clusterIDColumn	INTEGER NOT NULL,
  PRIMARY KEY($personIdColumn, $clusterIDColumn)
);
''';
const dropClusterPersonTable = 'DROP TABLE IF EXISTS $clusterPersonTable';
// End Clusters Table Fields & Schema Queries

/// Cluster Summary Table Fields & Schema Queries
const clusterSummaryTable = 'cluster_summary';
const avgColumn = 'avg';
const countColumn = 'count';
const createClusterSummaryTable = '''
CREATE TABLE IF NOT EXISTS $clusterSummaryTable (
  $clusterIDColumn	INTEGER NOT NULL,
  $avgColumn BLOB NOT NULL,
  $countColumn INTEGER NOT NULL,
  PRIMARY KEY($clusterIDColumn)
);
''';

const dropClusterSummaryTable = 'DROP TABLE IF EXISTS $clusterSummaryTable';

/// End Cluster Summary Table Fields & Schema Queries

/// notPersonFeedback Table Fields & Schema Queries
const notPersonFeedback = 'not_person_feedback';

const createNotPersonFeedbackTable = '''
CREATE TABLE IF NOT EXISTS $notPersonFeedback (
  $personIdColumn	TEXT NOT NULL,
  $clusterIDColumn	INTEGER NOT NULL,
  PRIMARY KEY($personIdColumn, $clusterIDColumn)
);
''';
const dropNotPersonFeedbackTable = 'DROP TABLE IF EXISTS $notPersonFeedback';
// End Clusters Table Fields & Schema Queries
