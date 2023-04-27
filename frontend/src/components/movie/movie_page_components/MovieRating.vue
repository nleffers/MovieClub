<template>
  <div class="movie-rating">
    <div class="average-rating">
      <div>TMDB RATING</div>
      <div><span class="bold">{{ voteAverage }}</span>/10</div>
      <div>{{ voteCount }}</div>
    </div>
    <div
      v-if="isLoggedIn"
      class="user-rating-wrapper"
    >
      <div>YOUR RATING</div>
        <div
          v-for="index in 10"
          :key="index"
          class="user-rating"
          :class="{ checked: reviewRating >= index }"
          @click="rateMovie(index)"
        >
          <i
            class="fa fa-star"
          ></i>
        </div>
      </div>
      <div
        v-else
        class="user-rating-wrapper"
      >
      <router-link :to="{ name: 'login_path', params: {} }">
        Sign in to rate the movie!
      </router-link>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useAuthStore } from '@/stores/auth'
import { useMovieStore } from '@/stores/movie'
import MovieReviewService from '@/services/movieReview.service'

export default defineComponent({
  setup() {
    const authStore = useAuthStore()
    const movieStore = useMovieStore()

    const { isLoggedIn, reviews } = storeToRefs(authStore)
    const { id: movieId, posterPath, releaseDate, title, voteAverage, voteCount } = storeToRefs(movieStore)

    return {
      movieStore,
      movieId,
      isLoggedIn,
      posterPath,
      releaseDate,
      reviews,
      title,
      voteAverage,
      voteCount,
    }
  },
  computed: {
    review() {
      return this.reviews && this.reviews.filter(review => review.tmdb_movie_id === this.movieId)[0]
    },
    reviewRating() {
      return this.review && this.review.review_rating || null
    }
  },
  methods: {
    rateMovie(value) {
      if (this.review) {
        let rating = null
        if (value !== this.reviewRating) { rating = value }

        const reviewInfo = {
          id: this.review.id,
          review_rating: rating
        }

        MovieReviewService.update(reviewInfo)
          .then(res => {
            if (res.status === 200) {
              this.movieStore.updateReview(res.data)
            } else if(res.status === 204) {
              this.movieStore.destroyReview(this.userReview.id)
            }
          })
          .catch(err => console.log(err))
      } else {
        const reviewInfo = {
          movie_title: this.title,
          movie_release_date: this.releaseDate,
          movie_poster_path: this.posterPath,
          review_rating: value,
          tmdb_movie_id: this.movieId
        }

        MovieReviewService.create(reviewInfo)
          .then(res => this.movieStore.createReview(res.data))
          .catch(err => console.log(err))
      }
    }
  }
})
</script>

<style scoped>
.movie-rating {
  display: inline-flex;
  margin-bottom: 15px;
}

.average-rating, .genres {
  border-right: 1px solid black;
  margin-right: 5px;
}

.genres, .user-rating-wrapper {
  margin-left: 5px;
  padding-left: 25px;
}

.average-rating {
  text-align: right;
}

.genres {
  text-align: center;
}

.user-rating-wrapper {
  width: 40%;
}

.user-rating {
  cursor: pointer;
  display: inline-block;
}

.checked {
  color: orange;
}

.bold {
  font-weight: bold;
}
</style>
