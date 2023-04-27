<template>
  <div class="movie-page-section">
    <div class="movie-page-section-header">
      <h2>User reviews</h2>
      <div class="review-count">{{ reviewsCount }}</div>
    </div>
    <br />
    <div
      v-if="latestReview"
      class="movie-review-section-body review-present"
    >
      <div class="review-heading">LATEST REVIEW</div>
      <div class="review-title">{{ latestReview.review_title }}</div>
      <div class="review-blog">{{ latestReview.review_blog }}</div>
    </div>
    <div
      v-else
      class="movie-review-section-body"
    >
      <div class="no-reviews">No reviews yet</div>
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

    const { reviews } = storeToRefs(movieStore)

    return {
      reviews,
    }
  },
  computed: {
    latestReview() {
      if (this.reviews.length === 0) { return null }

      return this.reviews[0]
    },
    reviewsCount() {
      return this.reviews.length
    },
  }
})
</script>

<style scoped>
.section-name {
  font-size: 2rem;
}

.review-count {
  font-size: 1.5rem;
  margin-top: auto;
  margin-left: 20px;
  margin-bottom: auto;
  justify-content: center;
}

.movie-review-section-body {
  box-sizing: border-box;
  margin: 1.5rem 0 1.5rem;
  padding: 1rem;
  text-align: left;
}

.review-present {
  border: 1px solid #FAFAFA;
  border-radius: 10px;
  box-shadow: 0 0 1px rgb(0 0 0 / 12%);
}

.no-reviews {
  text-align: center;
}

.review-heading {
  background-color: #F5C518;
  color: #000;
  font-size: 16px;
  width: 20%;
  padding-left: 1em;
}

.review-title {
  font-size: 24px;
  font-weight: bold;
}

.review-blog {
  overflow: hidden;
  text-overflow: ellipsis;
  height: fit-content;
}
</style>
