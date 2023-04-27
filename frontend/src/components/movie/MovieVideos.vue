<template>
  <div
    v-if="currentVideo"
    class="video-page"
  >
    <div class="video-viewer">
      <youtube-vue3
        :videoid="currentVideo.key"
        :width="1045"
        :height="587"
        :loop="0"
        :autoplay="0"
      />
    </div>
    <div class="video-information">
      <h2>{{ title }}</h2>
      <h4>{{ currentVideo.name }}</h4>
    </div>
    <div class="video-selector-header">
      <h4>More Videos</h4>
    </div>
    <div class="video-selector">
      <div class="video-selector-options">
        <div
          v-for="(video, index) in videoOptions"
          :key="index"
          :ref="'video-' + index"
          class="video-selector-option"
          @click="switchVideoInView(index)"
        >
          <div class="video-selector-option-div">{{ video.name }}</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { YoutubeVue3 } from 'youtube-vue3'
import MovieService from '@/services/movie.service'

export default defineComponent({
  props: {
    movieId: [Number, String],
  },
  components: {
    YoutubeVue3,
  },
  data() {
    return {
      title: '',
      videos: [],
    }
  },
  computed: {
    currentVideo() {
      if (this.videos.length === 0) { return }

      return this.videos[0]
    },
    currentVideoSource() {
      if (!this.currentVideo) { return }

      return `https://www.youtube.com/watch?v=${this.currentVideo.key}`
    },
    videoOptions() {
      if (this.videos.length === 0) { return }

      return this.videos.slice(1)
    },
  },
  created() {
    this.getMovieVideos()
  },
  methods: {
    getMovieVideos() {
      MovieService.getMovieVideos(this.movieId)
        .then(resp => {
          this.title = resp.data.title
          this.videos = resp.data.videos
        })
    },
    switchVideoInView(videoIndex) {
      this.videos = this.videos.concat(this.videos.splice(0, videoIndex + 1))
    },
  }
})
</script>

<style scoped>
.video-page {
  padding-top: 20px;
  width: 100%;
  color: #FAFAFA;
  margin: auto;
}

.video-information {
  float: left;
  padding-left: 15px;
  text-align: left;
  width: 100%;
}

.video-selector {
  width: 100%;
}

.video-selector-header {
  padding-left: 25px;
  text-align: left;
  width: 100%;
}

.video-selector-options {
  display: flex;
  overflow-x: scroll;
  width: 100%;
}

.video-selector-option {
  border: 1px solid #FAFAFA;;
  border-radius: 15px;
  cursor: pointer;
  display: inline-flex;
  height: 100px;
  min-width: 325px;
  margin-left: 12px;
  margin-right: 12px;
}

.video-selector-option-div {
  margin: auto;
  text-align: center;
}
</style>
