<template>
  <div class="featured-section">
    <div
      class="featured-movie"
      @click="openMovieVideo"
    >
      <img :src="featuredImageUrl" />
      <p>{{ featuredMovie.title }}</p>
    </div>
    <featured-movie-column
      :movies="moviesNotShowing"
      @changeMovieManually="$emit('changeMovieManually', $event)"
    />
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useStaticStore } from '@/stores/static'
import FeaturedMovieColumn from './featured_movie_section_components/FeaturedMovieColumn'

export default defineComponent({
  setup() {
    const staticStore = useStaticStore()

    const { secureBaseUrl } = storeToRefs(staticStore)

    return {
      secureBaseUrl,
    }
  },
  props: {
    movies: Array
  },
  components: {
    FeaturedMovieColumn
  },
  computed: {
    moviesNotShowing() {
      if (!this.movies) { return null }

      return this.movies.slice(1, 3)
    },
    featuredMovie() {
      return this.movies[0]
    },
    featuredImageUrl() {
      if (!this.featuredMovie) { return null }

      return this.secureBaseUrl + 'w780' + this.featuredMovie.backdrop_path
    },
  },
  methods: {
    openMovieVideo() {
      this.$router.push({ name: 'movie_videos_path', params: { movieId: this.featuredMovie.id }})
    }
  }
})
</script>

<style scoped>
.featured-section {
  width: 100%;
  display: inline-flex;
  position: relative;
}

.featured-movie {
  width: 780px;
  cursor: pointer;
}

.featured-movie p {
  color: #FAFAFA;
  font-size: 32px;
  font-weight: bold;
  overflow: hidden;
  padding-left: 15px;
  padding-top: 15px;
  position: absolute;
  text-overflow: ellipsis;
  top: 0px;
  white-space: nowrap;
  z-index: 99;
}
</style>
