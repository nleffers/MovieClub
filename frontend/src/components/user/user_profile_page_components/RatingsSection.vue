<template>
  <div class="user-profile-section user-profile-section-block">
    <div class="user-profile-section-header">
      <h2>Ratings</h2>
    </div>
    <div class="user-profile-section-container">
      <div
        v-for="(rating, index) in ratings"
        class="rating"
        :key="index"
        @click="openMovie(rating.tmdb_movie_id)"
      >
        <img :src="url(rating.movie_poster_path)" />
        <div class="rating-title">{{ rating.movie_title }}</div>
        <div class="rating-rating">{{ rating.review_rating }}/10</div>
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

    const { posterSizes, secureBaseUrl } = storeToRefs(staticStore)
    const { ratings } = storeToRefs(userStore)

    return {
      ratings,
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
.user-profile-section-container {
  width: 100%;
  display: inline-flex;
  overflow-x: scroll;
}

.rating {
  background-color: #FAFAFA;
  border: 1px solid black;
  border-radius: 10px;
  cursor: pointer;
  display: inline-block;
  margin-left: 10px;
  margin-right: 10px;
  padding-top: 10px;
  width: 200px;
}

.rating div {
  text-align: center;
}

.rating-title {
  text-overflow: ellipsis;
}
</style>
