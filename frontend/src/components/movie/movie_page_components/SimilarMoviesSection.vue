<template>
  <div class="movie-page-section">
    <div class="movie-page-section-header">
      <h2>More like this</h2>
    </div>
    <div class="movie-page-poster-options">
      <div
        v-for="(movie, index) in similarMovies"
        :key="index"
        :ref="'similar-movie-' + index"
        class="movie-page-poster-option"
      >
        <img :src="getPosterUrl(movie.poster_path)" />
        <div class="movie-page-poster-title">{{ movie.title }}</div>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useMovieStore } from '@/stores/movie'
import { useStaticStore } from '@/stores/static'

export default defineComponent({
  setup() {
    const movieStore = useMovieStore()
    const staticStore = useStaticStore()

    const { similarMovies } = storeToRefs(movieStore)
    const { posterSizes, secureBaseUrl } = storeToRefs(staticStore)

    return {
      posterSizes,
      secureBaseUrl,
      similarMovies,
    }
  },
  methods: {
    getPosterUrl(path) {
      return this.secureBaseUrl + this.posterSizes[2] + path
    },
  }
})
</script>

<style scoped>
.movie-page-poster-options {
  display: inline-flex;
  margin-left: 20px;
  margin-right: 20px;
  overflow-x: scroll;
  width: 100%;
}

.movie-page-poster-option {
  margin-left: 20px;
  margin-right: 20px;
}
</style>
