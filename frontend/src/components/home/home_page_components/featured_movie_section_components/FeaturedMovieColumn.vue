<template>
  <div class="movies-column">
    <div class="movies-column-header">Up Next</div>
    <div
      v-for="(movie, index) in movies"
      :key="index"
      :ref="'trailer-' + index"
      @click="$emit('changeMovieManually', movie.id)"
    >
      <div class="movie-not-showing-row">
        <img :src="url(movie.poster_path)" />
        <div class="movie-not-showing-row-title-section">
          <p class="movie-not-showing-row-title">{{ movie.title }}</p>
          <p>{{ movie.overview }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useStaticStore } from '@/stores/static'

export default defineComponent({
  setup() {
    const staticStore = useStaticStore()

    const { secureBaseUrl, posterSizes } = storeToRefs(staticStore)

    return {
      secureBaseUrl,
      posterSizes,
    }
  },
  props: {
    movies: Array
  },
  methods: {
    url(posterPath) {
      return this.secureBaseUrl + this.posterSizes[1] + posterPath
    }
  }
})
</script>

<style scoped>
.movies-column {
  text-align: left;
  width: calc(100% - 780px);
}

.movies-column-header {
  color: #FAFAFA;
  font-weight: bold;
  padding-left: 15px;
}

.movie-not-showing-row {
  background-color: #fafafa;
  border: 1px solid #ccc;
  border-radius: 10px;
  cursor: pointer;
  margin: 2px;
  height: 205px;
  padding: 20px 5px 20px 15px;
  position: relative;
  display: inline-flex;
  width: 100%;
}

.movie-not-showing-row-title-section {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: calc(100% - 130px);
  margin-left: 115px;
}

.movie-not-showing-row-title {
  font-weight: bold;
}

.movie-not-showing-row p {
  font-size: 12px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  margin-bottom: 0.5rem;
}
</style>
