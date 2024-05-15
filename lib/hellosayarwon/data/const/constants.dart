// api
const String backendApiServer = "https://wp.hellosayarwon.com"; // /wp-json/api/articles?page=1"; //  "https://imirror.mmsoftware100.com";

const String apiVersion = '$backendApiServer/wp-json/api';
const String loginEndpoint = '$apiVersion/login';
const String meEndpoint = '$apiVersion/me';
const String userRegisterEndpoint = '$apiVersion/register';
const String articleEndpoint = '$apiVersion/article';
const String articleSearchEndpoint = '$apiVersion/search';
const String categoryEndpoint = '$apiVersion/category';
const String articlesEndpoint = '$apiVersion/articles';
const String categoriesEndpoint = '$apiVersion/categories';

// database
const String dbName = 'hello_sayarwon';
const int dbVersion = 1;

const String articleTableName = 'articles';


// column names
String articleTableColumnId = "id";
String articleTableColumnTitle = "title";
String articleTableColumnDescription = "description";
String articleTableColumnThumbnail = "thumbnail";
String articleTableColumnCategoryId = "category_id";
String articleTableColumnFavourite = "favourite";
String articleTableColumnCreatedAt = "created_at";
String articleTableColumnUpdatedAt = "updated_at";
// table creation query
// String createPersonTableQuery = "CREATE TABLE $personTableName ($personTableColumnId INTEGER PRIMARY KEY AUTOINCREMENT,$personTableColumnName TEXT,$personTableColumnDescription TEXT)";

String createArticleSql = '''
      CREATE TABLE $articleTableName (
        $articleTableColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $articleTableColumnTitle TEXT,
        $articleTableColumnDescription TEXT,
        $articleTableColumnThumbnail TEXT,
        $articleTableColumnCategoryId INTEGER,
        $articleTableColumnFavourite INTEGER,
        $articleTableColumnCreatedAt TEXT,
        $articleTableColumnUpdatedAt TEXT
      )
''';




const String FCM_TOPIC = "shann_directory";