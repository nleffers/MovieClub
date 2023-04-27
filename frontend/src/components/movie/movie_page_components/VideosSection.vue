<template>
  <div class="movie-page-section">
    <div class="movie-page-section-header">
      <h2>Videos</h2>
      <div>{{ videoCount }}</div>
    </div>
    <div class="movie-page-section-options">
      <div
        v-for="(video, index) in videos"
        :key="index"
        :ref="'video-' + index"
        class="movie-page-section-option video-option"
        @click="openVideoPage"
      >
        <img :src="`https://img.youtube.com/vi/${video.key}/0.jpg`" />
        <div class="movie-page-video-name">{{ video.name }}</div>
      </div>
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

    const { id, videos, videoCount } = storeToRefs(movieStore)

    return {
      id,
      videos,
      videoCount,
    }
  },
  methods: {
    openVideoPage() {
      this.$router.push({ name: 'movie_videos_path', params: { movieId: this.id }})
    },
  }
})
</script>

<style scoped>
.movie-page-video-name {
  font-size: 16px;
  text-align: left;
  padding-left: 15px;
}

.video-option {
  cursor: pointer;
}
</style>
