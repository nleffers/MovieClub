<template>
  <div class="user-profile-section user-profile-section-block">
    <div class="user-profile-section-header">
      <h2>Reviews</h2>
    </div>
    <div
      v-for="(review, index) in reviews"
      :key="index"
      class="review"
    >
      <div class="review-movie-poster">
        <img
          :src="url(review.movie_poster_path)"
          @click="openMovie(review.tmdb_movie_id)"
        />
      </div>
      <div class="review-details">
        <div class="review-movie-details">
          <span class="review-movie-title" @click="openMovie(review.tmdb_movie_id)">{{ review.movie_title }}</span> ({{ review.movie_year }})
        </div>
        <div class="review-title">{{ review.review_title }}</div>
        <div class="review-date">{{ review.created_at }}</div>
        <div class="review-body">{{ review.review_blog }}</div>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useStaticStore } from '@/stores/static'
import { useUserStore } from '@/stores/user'

export default defineComponent({
  setup() {
    const staticStore = useStaticStore()
    const userStore = useUserStore()

    const { secureBaseUrl, posterSizes } = storeToRefs(staticStore)
    const { reviews } = storeToRefs(userStore)

    return {
      reviews,
      secureBaseUrl,
      posterSizes,
    }
  },
  methods: {
    url(posterPath) {
      return this.secureBaseUrl + this.posterSizes[1] + posterPath
    },
    openMovie(id) {
      this.$router.push({ name: 'movie_path', params: { id: id }})
    }
  }
})
</script>

<style scoped>
.review {
  display: inline-flex;
  margin-top: 15px;
  max-height: 265px;
}

.review-movie-poster {
  float: left;
  margin-right: 15px;
  width: 140px;
}

.review-movie-poster img {
  cursor: pointer;
}

.review-details {
  padding: 10px;
  text-align: left;
}

.review-movie-title {
  color: #136CB2;
  font-weight: bold;
}

.review-movie-title:hover {
  cursor: pointer;
}

.review-title {
  font-weight: bold;
}

.review-date {
  font-size: 11px;
}
</style>
