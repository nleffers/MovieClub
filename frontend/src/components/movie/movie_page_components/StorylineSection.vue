<template>
  <div class="movie-page-section">
    <div class="movie-page-section-header">
      <h2>Storyline</h2>
    </div>
    <div class="movie-page-storyline">
      <div class="movie-page-storyline-subsection">{{ overview }}</div>
      <div class="movie-page-storyline-subsection"><span class="bold">Taglines</span> {{ tagline }}</div>
      <div class="movie-page-storyline-subsection"><span class="bold">Genres</span> {{ genresString }}</div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useMovieStore } from '@/stores/movie'

export default defineComponent({
  setup() {
    const movieStore = useMovieStore()

    const { genres, overview, tagline } = storeToRefs(movieStore)

    return {
      genres,
      overview,
      tagline,
    }
  },
  computed: {
    genresString() {
      return this.genres.map(genre => genre.name).join(' | ')
    }
  }
})
</script>

<style scoped>
.movie-page-storyline {
  display: inline-block;
  text-align: left;
}

.movie-page-storyline-subsection {
  margin: auto;
  width: 85%;
}

.bold {
  font-weight: bold;
}
</style>
