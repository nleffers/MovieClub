<template>
  <div class="movie-info-wrapper">
    <div class="movie-info-top">
      <div class="movie-info-top-info">
        <h1>{{ title }}</h1>
        <div class="movie-info-top-sub-info">
          <p>{{ releaseYear }} | {{ movieRuntime }}</p>
        </div>
      </div>
      <div class="movie-info-top-ratings">
        <movie-rating />
      </div>
    </div>
    <div class="movie-info-directory">
      <div
        v-for="(option, index) in directoryOptions"
        :key="index"
        :ref="'option-' + index"
        class="movie-info-directory-option"
      >
        {{ option }}
      </div>
    </div>
    <div class="movie-info-bottom">
      <div class="movie-poster">
        <template v-if="posterPath">
          <img :src="posterUrl" alt="Poster">
        </template>
      </div>
      <div class="movie-info">
        <div class="movie-genres">{{ genresString }}</div>
        <p>{{ overview }}</p>
        <p><span class="label">Director</span> <span class="option">{{ movieDirectors }}</span></p>
        <p><span class="label">Writers</span> <span class="option">{{ movieWriters }}</span></p>
        <p><span class="label">Stars</span> <span class="option">{{ movieTopStars }}</span></p>
      </div>
      <div class="movie-actions">
        <div class="watchlist-options">
          <div
            v-if="onWatchlist"
            class="watchlist-option"
            @click="removeFromWatchlist"
          >
            Remove from Watchlist
          </div>
          <div
            v-else
            class="watchlist-option"
            @click="addToWatchlist"
          >
            Add to Watchlist
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useAuthStore } from '@/stores/auth'
import { useMovieStore } from '@/stores/movie'
import { useStaticStore } from '@/stores/static'
import MovieRating from './MovieRating.vue'

export default defineComponent({
  setup() {
    const authStore = useAuthStore()
    const movieStore = useMovieStore()
    const staticStore = useStaticStore()

    const { id: authId } = storeToRefs(authStore)
    const { id: movieId, directors, genres, overview, posterPath, releaseDate, runtime, title, topStars, watchlist, writers } = storeToRefs(movieStore)
    const { secureBaseUrl, posterSizes } = storeToRefs(staticStore)

    return {
      authStore,
      authId,
      secureBaseUrl,
      posterSizes,
      directors,
      genres,
      movieId,
      runtime,
      overview,
      posterPath,
      releaseDate,
      title,
      topStars,
      watchlist,
      writers,
    }
  },
  components: {
    MovieRating
  },
  data() {
    return {
      directoryOptions: [
        'Cast & Crew',
        'User Reviews'
      ]
    }
  },
  computed: {
    posterUrl() {
      return this.secureBaseUrl + this.posterSizes[2] + this.posterPath
    },
    genresString() {
      // just keep the array, don't make a string like this
      return this.genres.map(genre => genre.name).join(' | ')
    },
    releaseYear() {
      let date = this.releaseDate
      return date && date.slice(0, 4)
    },
    movieRuntime() {
      return `${Math.trunc(this.runtime / 60)}h ${this.runtime % 60}m`
    },
    movieDirectors() {
      return this.directors && this.directors.map(director => director.name).join(' | ')
    },
    movieTopStars() {
      return this.topStars && this.topStars.map(star => star.name).join(' | ')
    },
    movieWriters() {
      return this.writers && this.writers.map(writer => writer.name).join(' | ')
    },
    onWatchlist() {
      return this.watchlist && this.watchlist.some(movie => movie.tmdb_movie_id === this.movieId)
    },
  },
  methods: {
    addToWatchlist() {
      const params = {
        userId: this.authId,
        tmdbMovieId: this.movieId,
        movieTitle: this.title,
        moviePosterPath: this.posterPath
      }

      this.authStore.addToWatchlist(params)
    },
    removeFromWatchlist() {
      const params = {
        userId: this.authId,
        tmdbMovieId: this.movieId
      }

      this.authStore.removeFromWatchlist(params)
    }
  }
})
</script>

<style scoped>
.movie-info-wrapper {
  margin-top: 20px;
  margin-bottom: 20px;
  display: inline-block;
  color: #FAFAFA;
}

.movie-info-top {
  display: flex;
}

.movie-info-top-info {
  text-align: left;
  width: 60%;
}

.movie-info-top-ratings {
  text-align: right;
  width: 40%;
}

.movie-info-directory {
  border-radius: 5px;
  display: flex;
  width: 100%;
  background-color: #363636;
  color: #FAFAFA;
  height: 3rem;
  justify-content: right;
  padding-right: 25px;
  align-items: center;
}

.movie-info-directory-option::before {
  display: inline-block;
  margin: 0 0.5rem 0.2rem;
  content: '';
  font-size: 1rem;
  line-height: 0.5rem;
  padding: 1px;
  border-radius: 50%;
  vertical-align: middle;
}

.movie-info-bottom {
  display: flex;
  margin-top: 20px;
}

.movie-poster {
  float: left;
  width: 195px;
  padding-left: 5px;
  padding-right: 5px;
}

.movie-info {
  text-align: left;
  width: calc(75% - 195px);
  padding: 10px;
}

.movie-actions {
  width: 25%;
}

.watchlist-option {
  background-color: #3D3D3D;
  cursor: pointer;
  width: 100%;
}

.label {
  font-weight: bold;
}

.option {
  color: red;
}
</style>
