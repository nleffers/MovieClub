const getters = {
  movie: state => state.movie,
  id: state => state.movie.id,
  overview: state => state.movie.overview,
  posterPath: state => state.movie.poster_path,
  releaseDate: state => state.movie.release_date,
  runtime: state => state.movie.runtime,
  tagline: state => state.movie.tagline,
  title: state => state.movie.title,
  voteAverage: state => state.movie.vote_average,
  voteCount: state => state.movie.voteCount,
  credits: state => state.movie.credits || [],
  crew: (state, getters) => getters.credits.crew || [],
  cast: (state, getters) => getters.credits.cast || [],
  directors: (state, getters) => getters.crew.filter(crew => crew.job === 'Director'),
  writers: (state, getters) => getters.crew.filter(crew => crew.job === 'Writer'),
  topStars: (state, getters) => getters.cast.slice(0, 3),
  genres: state => state.movie.genres || [],
  images: state => state.movie.images || [],
  reviews: state => state.movie.reviews || [],
  similarMovies: state => state.movie.similar_movies || [],
  videos: state => state.movie.videos || [],
  videosCount: (state, getters) => getters.videos.length,
  searchResults: state => state.searchResults,
  loading: state => state.loading,
  // userHasRated: (state, getters, rootState, rootGetters) => {
  //   return rootGetters['AuthStore/movies'].some((movie) => { movie.title == getters.movie.title, movie.user_rating !== null })
  // }
}

export default getters
