import { defineStore } from 'pinia'
import MovieService from '@/services/movie.service'

const baseMovie = {
  id: '',
  overview: null,
  posterPath: null,
  rating: '',
  rating_count: '',
  release_date: null,
  runtime: null,
  tagline: null,
  title: '',
  videos: [],
  vote_average: null,
  voteCount: null,
  credits: [],
  genres: [],
  images: [],
  reviews: [],
  similar_movies: [],
}

export const useMovieStore = defineStore('movie', {
  state: () => {
    return {
      movie: { ...baseMovie },
      searchResults: [],
      loading: true
    }
  },
  getters: {
    id: state => state.movie.id,
    overview: state => state.movie.overview,
    posterPath: state => state.movie.poster_path,
    releaseDate: state => state.movie.release_date,
    runtime: state => state.movie.runtime,
    tagline: state => state.movie.tagline,
    title: state => state.movie.title,
    voteAverage: state => state.movie.vote_average,
    voteCount: state => state.movie.voteCount,
    credits: state => state.movie.credits || { cast: [], crew: [] },
    crew: state => state.movie.credits.crew || [],
    cast: state => state.movie.credits.cast || [],
    directors: state => state.movie && state.movie.credits && state.movie.credits.crew && state.movie.credits.crew.filter(crew => crew.job === 'Director'),
    writers: state => state.movie && state.movie.credits && state.movie.credits.crew && state.movie.credits.crew.filter(crew => crew.job === 'Writer'),
    topStars: state => state.movie && state.movie.credits && state.movie.credits.cast && state.movie.credits.cast.slice(0, 3),
    genres: state => state.movie.genres || [],
    images: state => state.movie.images || [],
    reviews: state => state.movie.reviews || [],
    similarMovies: state => state.movie.similar_movies || [],
    videos: state => state.movie.videos || [],
    videoCount: state => state.movie.videos.length,
    // searchResults: () => this.searchResults,
    // loading: () => this.loading,
    // userHasRated: (state, getters, rootState, rootGetters) => {
    //   return rootGetters['AuthStore/movies'].some((movie) => { movie.title == getters.movie.title, movie.user_rating !== null })
    // }
  },
  actions: {
    setMovie(movieId) {
      this.loading = true
      MovieService.get(movieId)
        .then(response => this.movie = response.data)
        .catch(err => console.log(err))
      this.loading = false
    },
    movieSearch(movies) {
      this.searchResults = movies
    },
    clearMovie() {
      this.movie = { ...baseMovie }
    },
    createReview(review) {
      this.movie.reviews = [...this.movie.reviews, review]
    },
    updateReview(reviewObject) {
      const reviewIndex = this.reviews.findIndex(review => review.id === reviewObject.id)
      const review = { ...this.reviews[reviewIndex], ...reviewObject }
      let reviews = this.reviews
      reviews.splice(reviewIndex, 1, review)
      this.reviews = [...reviews]
    },
    destroyReview(reviewId) {
      this.reviews = this.reviews.filter(review => review.id !== reviewId)
    },
  }
})
