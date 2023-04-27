<template>
  <div v-if="!loading" class="movie-page-container">
    <header-section />
    <div class="movie-page-sections">
      <videos-section />
      <images-section />
      <top-stars-section />
      <similar-movies-section />
      <review-section />
      <storyline-section />
    </div>
    <hr>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useMovieStore } from '@/stores/movie'

import HeaderSection from './movie_page_components/HeaderSection.vue'
import ImagesSection from './movie_page_components/ImagesSection.vue'
import ReviewSection from './movie_page_components/ReviewSection.vue'
import SimilarMoviesSection from './movie_page_components/SimilarMoviesSection.vue'
import StorylineSection from './movie_page_components/StorylineSection.vue'
import TopStarsSection from './movie_page_components/TopStarsSection.vue'
import VideosSection from './movie_page_components/VideosSection.vue'

export default defineComponent({
  setup() {
    const movieStore = useMovieStore()

    const { loading } = storeToRefs(movieStore)

    return {
      movieStore,
      loading,
    }
  },
  props: {
    id: [Number, String]
  },
  components: {
    HeaderSection,
    ImagesSection,
    ReviewSection,
    SimilarMoviesSection,
    StorylineSection,
    TopStarsSection,
    VideosSection
  },
  data() {
    return {
      createReviewModalOpen: false
    }
  },
  mounted() {
    this.movieStore.setMovie(this.id)
  },
  unmounted() {
    this.movieStore.clearMovie()
  },
})
</script>

<style scoped>
.movie-page-container {
  color: #FAFAFA;
}

.movie-page-sections {
  width: 90%;
  display: inline-block;
}
</style>

<style>
.movie-page-section {
  display: block;
  width: 100%;
  margin-top: 20px;
}

.movie-page-section-header {
  display: inline-flex;
  float: left;
}

.movie-page-section-options {
  display: inline-flex;
  overflow-x: scroll;
  width: 100%;
}

.movie-page-section-option {
  margin-left: 10px;
  margin-right: 10px;
}

.movie-page-section-option img {
  height: 250px;
}
</style>
