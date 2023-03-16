const String API_KEY = 'api_key=fbb9572d11b5458ac98f02b84f2bafc4';
const String BASE_URL = 'https://api.themoviedb.org/3';
const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';

const String GET_NOW_PLAYING_MOVIE = '$BASE_URL/movie/now_playing?$API_KEY';
const String GET_ON_AIRING_TV = '$BASE_URL/tv/airing_today?$API_KEY';

const String GET_POPULAR_MOVIE = '$BASE_URL/movie/popular?$API_KEY';
const String GET_POPULAR_TV = '$BASE_URL/tv/popular?$API_KEY';

const String GET_TOP_RATED_MOVIE = '$BASE_URL/movie/top_rated?$API_KEY';
const String GET_TOP_RATED_TV = '$BASE_URL/tv/top_rated?$API_KEY';

const String GET_DETAIL_MOVIE = '$BASE_URL/movie';
const String GET_DETAIL_TV = '$BASE_URL/tv';

const String GET_RECOMMENDED_MOVIE = 'recommendations?$API_KEY';
const String GET_RECOMMENDED_TV = 'recommendations?$API_KEY';

const String GET_SEARCH_MOVIE = '$BASE_URL/search/movie?$API_KEY&query=';
const String GET_SEARCH_TV = '$BASE_URL/search/tv?$API_KEY&query=';
